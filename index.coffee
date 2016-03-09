Promise = require 'bluebird'
_ = require 'lodash'
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
    yield createTree dbConnection, 'A', 8, 4
    console.log 'initialized database, start loading...'
    now = Date.now()
    result = yield dbConnection.loadTree('A')
    console.log 'Found POs', _.keys(result).length
    console.log 'Duration in ms', (Date.now() - now)


initialize()


