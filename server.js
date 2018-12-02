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

router.get('/reservation', async (req, res) => {
  const lots = await query(`SELECT lot_id lotId, CONCAT(address, '. ', city, ', ', state, ', ', zip_code) address FROM parking_lot;`);
  for (const lot of lots) {
    lot.vehicles = await query(`SELECT vin, make, model, year, color FROM vehicle WHERE lot_id = ?;`, lot.lotId);
    for (const vehicle of lot.vehicles) {
      vehicle.rate = 8.5;
      vehicle.existingReservations = await query(`SELECT reservation_start start, reservation_end end FROM trip_details WHERE reservation_end > UNIX_TIMESTAMP() * 1000 AND vin = ?;`, vehicle.vin);
    }
  }
  return lots;
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

router.get('/analytics', async (req, res) => {
  if (!req.session.identity || !(await isEmployee(req.session.identity))) {
    res.status(401).send('Unauthorized');
    return;
  }
  const mostTripsClient = await query(`SELECT email_address 'Email Address' FROM trip_details GROUP BY email_address HAVING COUNT(*) = (SELECT COUNT(*) count FROM trip_details GROUP BY email_address ORDER BY count DESC LIMIT 1);`);
  const queries = [{
    label: 'Fees associated with client credit cards',
    columns: ['Credit Card Number', 'Total Fees'],
    table: await query(`SELECT credit_card_number 'Credit Card Number', SUM(surcharge) - SUM(waived) as 'Total Fees' FROM incident NATURAL JOIN trip_details NATURAL JOIN client WHERE surcharge > 0 OR waived > 0 GROUP BY credit_card_number;`)
  }, {
    label: 'Client with the most amount of trips',
    columns: ['Email Address'],
    table: mostTripsClient,
    action: {
      message: 'Add 10 credits.',
      method: 'POST',
      url: '/addCredits',
      body: {
        credits: 10,
        client: Object.values(mostTripsClient)[0]
      }
    }
  }, {
    label: 'Unviewed feedback',
    columns: ['Email Address', 'Subject', 'Message'],
    table: await query(`SELECT email_address 'Email Address', Subject, Message FROM feedback WHERE viewed = FALSE;`)
  }, {
    label: 'Cars that haven\'t had maintenance in a year.',
    columns: ['License Plate Number'],
    table: await query(`SELECT license_plate_number 'License Plate Number' FROM vehicle WHERE vin NOT IN (SELECT vin FROM maintenance WHERE utc > (UNIX_TIMESTAMP() - 365 * 24 * 60 * 60) * 1000);`)
  }, {
    label: 'Vehicles parked in New York, New York',
    columns: ['Make', 'Model'],
    table: await query(`SELECT Make, Model FROM vehicle NATURAL JOIN parking_lot WHERE city = 'New York' AND state = 'NY';`)
  }, {
    label: 'Names of all managers',
    columns: ['First Name', 'Last Name'],
    table: await query(`SELECT first_name 'First Name', last_name 'Last Name' FROM account WHERE email_address IN (SELECT DISTINCT manager_email_address email_address FROM employee WHERE manager_email_address IS NOT NULL);`)
  }, {
    label: 'Latest coordinates and timestamp of car "VZA-1234"',
    columns: ['Coordinates', 'Timestamp'],
    table: await query(`SELECT Coordinates, utc 'Timestamp' FROM vehicle NATURAL JOIN location_record WHERE license_plate_number = 'VZA-1234' ORDER BY utc DESC LIMIT 1;`)
  }, {
    label: 'Customer service representative emails',
    columns: ['Email Address'],
    table: await query(`SELECT email_address 'Email Address' FROM role NATURAL JOIN job_type WHERE name LIKE '%customer service rep%';`)
  }, {
    label: 'Incident surcharges less than $100 on April Fools day',
    columns: ['Reservation', 'Surcharge'],
    table: await query(`SELECT Reservation, Surcharge FROM trip_details NATURAL JOIN incident WHERE MONTH(FROM_UNIXTIME(FLOOR(actual_start / 1000))) = 4 AND DAY(FROM_UNIXTIME(FLOOR(actual_start / 1000))) = 1;`)
  }, {
    label: 'Capacity of parking lots in 23220',
    columns: ['Address', 'Capacity'],
    table: await query(`SELECT Address, Capacity FROM parking_lot WHERE zip_code = 23220;`)
  }, {
    label: 'VIN and Parking Location of oldest cars',
    columns: ['VIN', 'Parking Location'],
    table: await query(`SELECT VIN, CONCAT(address, '. ', city, ', ', state) 'Parking Location' FROM vehicle NATURAL JOIN parking_lot WHERE year = (SELECT year FROM vehicle ORDER BY year ASC LIMIT 1);`)
  }, {
    label: '6-figure salary employees that made a reservation today',
    columns: ['Name'],
    table: await query(`SELECT CONCAT(first_name, ' ', last_name) 'Name' FROM account NATURAL JOIN employee NATURAL JOIN trip_details WHERE wage BETWEEN 100000 AND 999999.99 AND DATE(FROM_UNIXTIME(FLOOR(reservation_start / 1000))) = CURDATE();`)
  }, {
    label: 'Clients living in Virginia',
    columns: ['Email Address'],
    table: await query(`SELECT email_address 'Email Address' FROM client NATURAL JOIN account WHERE state = 'VA';`)
  }, {
    label: 'Wage of CEOs',
    columns: ['Name', 'Wage'],
    table: await query(`SELECT CONCAT(first_name, ' ', last_name) Name, Wage FROM employee NATURAL JOIN account WHERE manager_email_address IS NULL;`)
  }, {
    label: 'End times of reservations that are still in progress',
    columns: ['Reservation End Time'],
    table: await query(`SELECT reservation_end 'Reservation End Time' FROM trip_details WHERE actual_start IS NOT NULL AND actual_end IS NULL;`)
  }];
  res.json(queries);
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
