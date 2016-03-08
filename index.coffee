Promise = require 'bluebird'
DbConnection = require './DbConnection'
{createTree} = require './create-data'

config =
    serverAddress: 'http://127.0.0.1:8529'
    databaseName: 'hackathon'
    collections: [
        'po'
    ]
    edgeCollections: [
        'relation'
    ]

initialize = Promise.coroutine ->
    dbConnection = new DbConnection config
    yield dbConnection.initializeDatabase()
    root = yield dbConnection.createPo {name: 'root'}
    child = yield dbConnection.createPo {name: 'child'}

    yield dbConnection.createRelation {type: 'parent-child'}, root, child

    yield createTree dbConnection, 'A', 5, 4




initialize()


