class User < ApplicationRecord

	# associations
	has_many :posts, dependent: :destroy

	# validations
	validates_presence_of :username
	
end
