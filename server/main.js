require('dotenv').config();

// Now you can access your environment variables
const dbHost = process.env.DB_HOST;
console.log(dbHost); // Outputs 'localhost'

const express = require("express")

const db = require('./db');

db.query('SELECT * FROM yourTable', (err, results) => {
    if (err) throw err;
    console.log(results);
});
