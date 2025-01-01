const mysql = require('mysql');
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'nguyen.mh.tony@gmail.com',
    password: 'password',
    database: 'unimapDatabase'
});

connection.connect(err => {
    if (err) throw err;
    console.log('Connected to MySQL!');
});

module.exports = connection;
