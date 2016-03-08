Promise = require 'bluebird'
Database = require('arangojs').Database

config =
    serverAddress: 'http://127.0.0.1:8529'
    databaseName: 'hackathon'
    collections: [
        'po'
        'relation'
    ]

class DbConnection
    constructor(@config) ->

    openDatabase: ->
        @db = new Database @config.serverAddress #" #'http://127.0.0.1:8529'

    initializeDatabase: Promise.coroutine ->
        @openDatabase()
        @_initDatabase @config.databaseName
        @_initCollections @config.collections


    _initDatabase: (name) ->
        dbNames = yield @db.listUserDatabases()
        if name in dbNames
            console.log 'Dropping database ' + name
            yield @db.dropDatabase name

        console.log 'Creating database ' + name
        yield @db.createDatabase name

    _initCollections: (collections) ->
        for collection in collections
            @_initCollection collection

    _initCollection: (name) ->
        collection = db.collection name
        collection.create()

    # createDocument: (document) ->


