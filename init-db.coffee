config = {
    dbName: 'hackathon'
    collectionName: 'planning-objects'
}

db = require('arangojs')()
db.listUserDatabases()
    .then (dbNames) ->
        if config.dbName in dbNames
            console.log 'Database already exists'
        else
            db.createDatabase(config.dbName).then(
                () -> console.log('Database created'),
                (err) -> console.error('Failed to create database:', err)
            )
