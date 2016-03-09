Promise = require 'bluebird'
Database = require('arangojs').Database
PoModel = require './PoModel'

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
        yield @_initGraph()

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

    _initGraph: Promise.coroutine ->
        graph = @db.graph @config.graphName
        yield graph.create(@config.graph)

    createPo: Promise.coroutine (poData) ->
        yield @collections.po.save poData

    createRelation: Promise.coroutine (relationData, from, to) ->
        yield @collections.relation.save relationData, from, to

    loadAllPOs: Promise.coroutine ->
        (yield @collections.po.all())._result

    loadPoByName: Promise.coroutine (name) ->
        dbModel = (yield @collections.po.byExample(name: name))._result[0]
        return new PoModel dbModel

    # never loads more than 1001 objects
    loadPoSubtree: Promise.coroutine (po) ->
        query = "FOR v, e IN 1..100000 OUTBOUND '#{po.id()}' GRAPH '#{@config.graphName}' RETURN {po: v, relation: e}"
        (yield @db.query query)._result

    # dirty
    loadTree: Promise.coroutine (rootName) ->
        poCollection = {}
        rootPo = yield @loadPoByName rootName
        poCollection[rootPo.id()] = rootPo

        edgeChildList = yield @loadPoSubtree rootPo
        for {po, relation} in edgeChildList
            poModel = new PoModel po
            poCollection[poModel.id()] = poModel
            parent = poCollection[relation._from]
            relation.po = poModel
            parent.addRelation relation
            poModel.setParent parent

        return poCollection














# createDocument: (document) ->

module.exports = DbConnection

