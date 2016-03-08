Database = require('arangojs').Database
db = new Database 'http://127.0.0.1:8529'
console.log 'db', db

#createDatabase (name)
#removeDatabase (name)
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

