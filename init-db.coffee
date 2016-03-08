db = require('arangojs')()
db.listDatabases()
    .then (names) ->
        console.log 'names: ', names
