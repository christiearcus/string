require 'pry'
require 'active_record'
require './db_config'
require './models/user'
require './models/trip'

ActiveRecord::Base.logger = Logger.new(STDERR)

binding.pry
