class PoModel
    constructor: (@dbModel) ->
        @relations = []

    getName: ->
        return @dbModel.name

    getRelations: ->
        return @relations