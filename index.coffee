Database = require('arangojs').Database
db = new Database 'http://127.0.0.1:8529'
console.log 'db', db
