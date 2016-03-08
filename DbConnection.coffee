Promise = require 'bluebird'
Database = require('arangojs').Database

class DbConnection
    constructor: (@config) ->

    openDatabase: ->
        @db = new Database @config.serverAddress
        @collections = {}

    initializeDatabase: Promise.coroutine ->
        @openDatabase()
        yield @_initDatabase @config.databaseName
        yield @_initCollections()
        yield @_initEdgeCollections()

    _initDatabase: Promise.coroutine (name) ->
        dbNames = yield @db.listUserDatabases()
        if name in dbNames
            console.log 'Dropping database ' + name
            yield @db.dropDatabase name

        console.log 'Creating database ' + name
        yield @db.createDatabase name
        @db.useDatabase name

    _initCollections: Promise.coroutine ->
        for collection in @config.collections
            yield @_initCollection collection

    _initCollection: Promise.coroutine (name) ->
        collection = @db.collection name
        @collections[name] = collection
        yield collection.create()

    _initEdgeCollections: Promise.coroutine ->
        for collection in @config.edgeCollections
            yield @_initEdgeCollection collection

    _initEdgeCollection: Promise.coroutine (name) ->
        collection = @db.edgeCollection name
        @collections[name] = collection
        yield collection.create()

    createPo: Promise.coroutine (poData) ->
        yield @collections.po.save poData

    createRelation: Promise.coroutine (relationData, from, to) ->
        yield @collections.relation.save relationData, from, to






    # createDocument: (document) ->

module.exports = DbConnection

