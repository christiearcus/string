require 'active_record'
require './db_config'
require './models/user'
require './models/trip'
require './models/expense'

ActiveRecord::Base.logger = Logger.new(STDERR)
