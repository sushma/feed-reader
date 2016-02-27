class User < ActiveRecord::Base

	validates :name, presence: true
	validates :email, presence: true
	has_secure_password
  validates :password, length: { minimum: 8 }, allow_nil: true
	
end
