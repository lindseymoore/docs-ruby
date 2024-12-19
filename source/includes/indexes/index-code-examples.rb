require 'mongo'

# Replace the placeholders with your credentials
uri = "<connection string>"

# Sets the server_api field of the options object to Stable API version 1
options = { server_api: { version: "1" }}

# Creates a new client and connect to the server
client = Mongo::Client.new(uri, options)

database = client.use('<database name>')
collection = database[:<collection name>]

# Single Field
# start-index-single
collection.indexes.create_one({ <field name>: 1 })
# end-index-single

# Compound
# start-index-compound
collection.indexes.create_one({ <field name 1>: -1, <field name 2>: 1 })
# end-index-compound

# Multikey
# start-index-multikey
collection.indexes.create_one({ <field name>: 1 })
# end-index-multikey

# Geospatial
# start-index-geospatial
collection.indexes.create_one({ <GeoJSON field name>: '2dsphere' })
# end-index-geospatial

# Atlas Search

# Create Search Index
# start-create-search-index
index_definition = {
  definition: {
    mappings: {
      dynamic: false,  
      fields: {
        <field name>: {
          type: '<field type>'
        }
      }
    }
  }
}
collection.database.command(
  createSearchIndexes: '<collection name>',
  indexes: [index_definition]
)
# end-create-search-index

# List Search Indexes
# start-list-search-indexes
collection.database.command(listSearchIndexes: '<collection name>')
# end-list-search-indexes

# Update Search Indexes
#start-update-search-indexes
collection.database.command(
    updateSearchIndex: '<collection name>',
    name: '<index name>'
)
#end-update-search-indexes

# Delete Search Index
# start-drop-search-index
result = collection.database.command(
    dropSearchIndex: '<collection name>',
    name: '<index name>'
)
# end-drop-search-index

# Text Index
# start-text
collection.indexes.create_one( { :<field name> => 'text' } )
# end-text

# Create Many
# start-index-create-many
collection.indexes.create_many([
  { key: { <field name 1>: 1 } },
  { key: { <field name 2>: -1 } },
])
# end-index-create-many

# Delete an Index
# start-drop-single-index
collection.indexes.drop_one( '<index name>' )
# end-drop-single-index

# Drops all indexes in the collection.
# start-drop-all-index
collection.indexes.drop_all
# end-drop-all-index

# List an Index
# start-list-indexes
all_indexes.each do |index|
    puts index
end
# end-list-indexes

client.close
