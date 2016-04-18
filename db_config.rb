require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'traveller'
}

ActiveRecord::Base.establish_connection(options)
