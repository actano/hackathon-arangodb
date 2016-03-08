Promise = require 'bluebird'
DbConnection = require './DbConnection'
{createTree} = require './create-data'

config =
    serverAddress: 'http://127.0.0.1:8529'
    databaseName: 'hackathon'
    graphName: 'poTree'
    graph:
        edgeDefinitions: [{
            collection: 'relation',
            from: [
                'po'
            ],
            to: [
                'po'
            ]
        }]
    collections: [
        'po'
    ]
    edgeCollections: [
        'relation'
    ]

initialize = Promise.coroutine ->
    dbConnection = new DbConnection config
    yield dbConnection.initializeDatabase()
    yield createTree dbConnection, 'A', 5, 4

initialize()


