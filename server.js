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
    if (typeof value == 'object' && !assertSchema(actual[key], value)) {
      return false;
    }
  }
  return true;
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
  try {
    const salt = await bcrypt.genSalt(1);
    const passwordHash = await bcrypt.hash(password, salt);
    await query(`INSERT INTO
      account(email_address, password_hash, salt, first_name, last_name, address, city, state, zip_code, phone_number, creation_date)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);`,
      email, passwordHash, salt, firstName, lastName, address, city, state, +zip, +phone, Date.now());
    console.log(`Created account ${email}.`);
    req.session.identity = email;
    res.send({
      success: true
    });
  } catch (err) {
    console.error(`Error while creating account.`, req.body, err);
    res.status(500).send('Server Error');
  }
});

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
