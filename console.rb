require 'active_record'
require './db_config'
require './models/user'
require './models/trip'
require './models/expense'
require 'pry'

ActiveRecord::Base.logger = Logger.new(STDERR)
binding.pry
