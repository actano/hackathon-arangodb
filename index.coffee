Promise = require 'bluebird'
DbConnection = require './DbConnection'

config =
    serverAddress: 'http://127.0.0.1:8529'
    databaseName: 'hackathon'
    collections: [
        'po'
    ]
    edgeCollections: [
        'relation'
    ]

dbConnection = new DbConnection config

dbConnection.initializeDatabase()

