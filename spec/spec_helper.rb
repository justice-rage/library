require 'rspec'
require 'pg'
require 'author'
require 'book'
# require 'artist'
require 'pry'

# shared code for clearing tests between runs & connecting to the DB:

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM authors *;")
    DB.exec("DELETE FROM books *;")
    # DB.exec("DELETE FROM artists *;")
  end
end