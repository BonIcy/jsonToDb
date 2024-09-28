const mysql2 = require('mysql2/promise');
require('dotenv').config();

const host = process.env.DB_HOST256;
const port = process.env.DB_PORT256;
const user = process.env.DB_USER256;
const password = process.env.DB_PASSWORD256;
const database = process.env.DB_DATABASE256;

const connectionPromise = mysql2.createConnection({
  host,
  port,
  user,
  password,
  database,
});

connectionPromise.then((connection) => {
  console.log('Connecting to database successfully');
}).catch((err) => {
  console.error('Error trying to connect to db', err);
});

module.exports = connectionPromise;