Promise = require 'bluebird'
Database = require('arangojs').Database

db = new Database 'http://127.0.0.1:8529'

module.exports = {
    initDatabase: Promise.coroutine (name) ->
        dbNames = yield db.listUserDatabases()
        if name in dbNames
            console.log 'Dropping database ' + name
            yield db.dropDatabase name

        console.log 'Creating database ' + name
        yield db.createDatabase name
#
#createCollection (name)
#createEdgeCollection (name)
#
#createDocument (object)
#createEdge (from, to, {name, type, deleted, ...})
#
#
#createPO
#createLink
#createParentChildRelation
#createReference
#
#createOrganization
#createUser
#createLinkToRootPos

# How to deal with order of children
# Relations between relations?
# position in relation
# index in parent

}

