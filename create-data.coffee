Promise = require 'bluebird'
{RELATION_TYPE} = require './constants'

randomSeed = require 'random-seed'
random = randomSeed.create(1)


createTree = Promise.coroutine (dbConnection, name, maxDepth, maxRelations) ->
    parent = yield dbConnection.createPo {name: name}
    unless maxDepth < 2
        for childIndex in [1 .. random(maxRelations + 1)]
            relationType = if random(100) > 20 then RELATION_TYPE.PARENT_CHILD else RELATION_TYPE.REFERENCE
            child = yield createTree dbConnection, "#{name}_#{childIndex}", maxDepth - 1, maxRelations
            yield dbConnection.createRelation {type: relationType}, parent, child

    return parent

module.exports = {createTree}
