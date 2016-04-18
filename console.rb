require 'pry'
require 'active_record'
require './db_config'
require './models/user'

ActiveRecord::Base.logger = Logger.new(STDERR)

binding.pry
