class PoModel
    constructor: (@dbModel) ->
        @relations = []
        @parent = undefined

    id: ->
        return @dbModel._id

    getName: ->
        return @dbModel.name

    setParent: (@parent) ->

    addRelation: (relation) ->
        @relations.push(relation)

module.exports = PoModel