class User < ApplicationRecord

	#encrypt password
	has_secure_password

	# associations
	has_many :posts, dependent: :destroy

	# validations
	validates_presence_of :username, :email, :password_digest
	
end
