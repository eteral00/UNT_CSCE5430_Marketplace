"use strict";

// mysql2 module, for mysql 8.xx,
// if using mysql 5.xx, use mysql module
// const mysql = require('mysql');
const mySQL = require('mysql2');

// Create mysql db connection
const mySQL_DbConnection = mySQL.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "marketplace"
});

// Connect to mysql db
mySQL_DbConnection.connect(function(err) {
  if (err) { throw err };
  console.log("Connected to MySQL DB!");

});


module.exports = mySQL_DbConnection;