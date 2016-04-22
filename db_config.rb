require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'traveller'
}

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || options)
