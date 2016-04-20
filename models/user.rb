class User < ActiveRecord::Base
  has_secure_password
  validates :email_address, uniqueness: true
  has_many :trips
end
