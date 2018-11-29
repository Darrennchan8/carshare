const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const bcrypt = require('bcrypt');
const session = require('express-session');

const app = express();
app.use(bodyParser.urlencoded({ extended: true}));
app.use(bodyParser.json());
app.use(session({
  secret: '$2b$04$qEIOs7SmG8ORHvhi2Xzk4.',
  cookie: {
    maxAge: 60000
  }
}));

const port = process.env.port || 8080;

const router = express.Router();

router.get('/', (req, res) => res.send('ok'));

app.use('/api', router);

const db = mysql.createConnection({
  host: '35.196.77.193',
  user: 'root',
  password: 'carshare',
  database: 'carshare'
});

db.connect(err =>
    err ?
        console.error('Unable to connect to database', err) :
        console.log('Connected to mysql!'));

const query = function(str, ...params) {
  return new Promise((resolve, reject) => {
    db.query(str, params, (error, results, fields) => {
      if (error) {
        console.error({
          invocation: [str, ...params],
          error
        });
      }
      resolve(results);
    });
  });
};

const assertSchema = function(actual, expected) {
  for (const [key, value] of Object.entries(expected)) {
    if (actual[key] === null || typeof actual[key] != value) {
      return false;
    }
  }
  return true;
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
    res.json({
      success: true
    });
  } else {
    res.json({
      success: false,
      message: 'Incorrect email or password.'
    });
  }
});

router.post('/logout', async (req, res) => {
  req.session.identity = null;
  res.json({
    success: true
  });
});

router.post('/debug', async (req, res) => {
  res.json({
    session: req.session
  });
});

app.listen(port);
console.log(`Running on port ${port}.`);
