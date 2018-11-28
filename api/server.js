const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');

const app = express();
app.use(bodyParser.urlencoded({ extended: true}));
app.use(bodyParser.json());

const port = process.env.port || 8080;

const router = express.Router();

router.get('/', (req, res) => res.send('ok'));

app.use('/api', router);

app.listen(port);
console.log(`Running on port ${port}.`);

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

