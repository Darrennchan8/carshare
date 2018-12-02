const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const bcrypt = require('bcrypt');
const session = require('express-session');
const path = require('path');

const port = process.env.port || 8080;

const app = express();
app.use(bodyParser.urlencoded({ extended: true}));
app.use(bodyParser.json());
app.use(session({
  secret: '$2b$04$qEIOs7SmG8ORHvhi2Xzk4.',
  cookie: {
    maxAge: 60000
  }
}));

app.use('/', express.static('frontend'));

const router = express.Router();
app.use('/api', router);

const db = mysql.createConnection({
  host: '35.196.77.193',
  user: 'root',
  password: 'carshare',
  database: 'carshare'
});

const initDB = function() {
  return new Promise((resolve, reject) => {
    db.connect(err => {
      if (err) {
        console.error('Unable to connect to database.', err);
        console.error('Retrying in 5s.');
        setTimeout(() => initDB().then(resolve), 5000);
      } else {
        console.log('Connected to mysql!');
        resolve();
      }
    });
  });
};

const query = function(str, ...params) {
  return new Promise((resolve, reject) => {
    db.query(str, params, (error, results, fields) => {
      if (error) {
        reject(error);
        console.error({
          invocation: [str, ...params],
          error
        });
      } else {
        resolve(results);
      }
    });
  });
};

const assertSchema = function(actual, expected) {
  for (const [key, value] of Object.entries(expected)) {
    if (actual[key] === null || typeof value == 'string' && typeof actual[key] != value) {
      return false;
    }
    if (typeof value == 'object' && (typeof actual[key] != 'object' || !assertSchema(actual[key], value))) {
      return false;
    }
  }
  return true;
};

const accountExists = async function(email) {
  const records = await query('SELECT * FROM account WHERE email_address=?', email);
  return !!records.length;
};

const isEmployee = async function(email) {
  const records = await query('SELECT * FROM employee WHERE email_address=?', email);
  return !!records.length;
};

const isClient = async function(email) {
  const records = await query('SELECT * FROM client WHERE email_address=?', email);
  return !!records.length;
};

const getAccountRoles = async function(email) {
  return {
    isEmployee: await isEmployee(email),
    isClient: await isClient(email)
  };
};

router.post('/login', async (req, res) => {
  console.log(req.body);
  if (!assertSchema(req.body, {
        email: 'string',
        password: 'string'
      })) {
    res.status(400).send('Bad Request');
    return;
  }
  const { email, password } = req.body;
  const expected = (await query('SELECT * FROM account WHERE email_address=?', email))[0] || {};
  const actualHash = await bcrypt.hash(password, expected.salt || bcrypt.genSaltSync(1));
  if (expected && expected.password_hash == actualHash) {
    req.session.identity = email;
    console.log(`${email} successfully logged in.`);
    res.json({
      success: true,
      ...(await getAccountRoles(email))
    });
  } else {
    console.log(`${email} unsuccessfully attempted login.`);
    res.json({
      success: false,
      message: 'Incorrect email or password.'
    });
  }
});

router.post('/accountDetails', async (req, res) => {
  if (!req.session.identity) {
    res.status(401).send('Unauthorized');
    return;
  }
  res.json({
    success: true,
    ...(await getAccountRoles(req.session.identity))
  });
});

router.post('/register', async (req, res) => {
  if (!assertSchema(req.body, {
    email: 'string',
    password: 'string',
    name: {
      first: 'string',
      last: 'string'
    },
    address: {
      address: 'string',
      city: 'string',
      state: 'string',
      zip: 'string'
    },
    phone: 'string'
  })) {
    res.status(400).send('Bad Request');
  }
  const {
    email,
    password,
    name: { first: firstName, last: lastName },
    address: { address, city, state, zip },
    phone
  } = req.body;
  if (await accountExists(email)) {
    res.json({
      success: false,
      message: 'An account with this email already exists!'
    });
    return;
  }
  try {
    const salt = await bcrypt.genSalt(1);
    const passwordHash = await bcrypt.hash(password, salt);
    await query(`INSERT INTO
      account(email_address, password_hash, salt, first_name, last_name, address, city, state, zip_code, phone_number, creation_date)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);`,
      email, passwordHash, salt, firstName, lastName, address, city, state, +zip, +phone, Date.now());
    console.log(`Created account ${email}.`);
    req.session.identity = email;
    res.json({
      success: true
    });
  } catch (err) {
    console.error(`Error while creating account.`, req.body, err);
    res.status(500).send('Server Error');
  }
});

router.post('/createClientAccount', async (req, res) => {
  if (!assertSchema(req.body, {
    driversLicenseNumber: 'string',
    creditCardNumber: 'string'
  })) {
    res.status(400).send('Bad Request');
  }
  const {
    driversLicenseNumber,
    creditCardNumber
  } = req.body;
  const identity = req.session.identity;
  if (!identity) {
    res.status(401).send('Unauthorized');
    return;
  }
  if (await isClient(identity)) {
    res.json({
      success: false,
      message: 'This account is already a client!'
    });
    return;
  }
  try {
    await query(`INSERT INTO client(email_address, drivers_license_number, credit_card_number, credits) VALUES (?, ?, ?, ?)`,
        identity, driversLicenseNumber, creditCardNumber, 0);
    res.json({
      success: true
    });
  } catch (err) {
    console.error(`Error while creating client.`, req.body, err);
    res.status(500).send('Server Error');
  }
});

// router.get('/analytics', async (req, res) => {
//   if (!req.session.identity || !(await isEmployee(req.session.identity))) {
//     res.status(401).send('Unauthorized');
//     return;
//   }
//   const queries = [{
//     label: 'Fees associated with client credit cards',
//     table: await query(`SELECT credit_card_number 'Credit Card Number', SUM(surcharge) - SUM(waived) as 'Total Fees' FROM incident NATURAL JOIN trip_details NATURAL JOIN client WHERE surcharge > 0 OR waived > 0 GROUP BY credit_card_number;`)
//   }, {
//     label: 'Client with the most amount of trips',
//     table: await query(`SELECT email_address 'Email Address' FROM trip_details GROUP BY email_address HAVING COUNT(*) = (SELECT COUNT(*) count FROM trip_details GROUP BY email_address ORDER BY count DESC LIMIT 1);`),
//     action: {
//       message: 'Add 10 credits.',
//       url: '/addCredits',
//       body: {
//       }
//     }
//   }, {
//     label: 'Unviewed feedback',
//     table: await query(`SELECT email_address 'Email Address', Subject, Message FROM feedback WHERE viewed = FALSE;`)
//   }, {
//     label: 'Cars that haven\'t had maintenance in a year.',
//     table: await query(`SELECT license_plate_number 'License Plate Number' FROM vehicle WHERE vin NOT IN (SELECT vin FROM maintenance WHERE utc > (UNIX_TIMESTAMP() - 365 * 24 * 60 * 60) * 1000);`)
//   }, {
//     label: 'Vehicles parked in New York, New York',
//     table: await query(`SELECT Make, Model FROM vehicle NATURAL JOIN parking_lot WHERE city = 'New York' AND state = 'NY';`);
//   }];
//   res.json(queries);
// });

router.post('/logout', async (req, res) => {
  req.session.identity && console.log(`${req.session.identity} logged out.`);
  req.session.identity = null;
  res.json({
    success: true
  });
});

router.all('/debug', async (req, res) => {
  res.json({
    session: req.session
  });
});

console.log('Waiting for database...');
initDB().then(() => {
  app.listen(port);
  console.log(`Running on port ${port}.`);
});
