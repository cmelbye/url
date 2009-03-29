# require AR
require 'rubygems'
require 'active_record'

# connect to the database (sqlite in this case)
ActiveRecord::Base.establish_connection({
      :adapter => "sqlite3", 
      :dbfile => "database.sqlite3"
})

class CreateUrls < ActiveRecord::Migration
  def self.up
    create_table :urls do |t|
      t.string :url
      t.string :code
      t.string :note
    end
  end
  
  def self.down
    drop_table :urls
  end
end

# run the migration
CreateUrls.migrate(:up)
