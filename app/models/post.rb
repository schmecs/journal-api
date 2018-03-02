class Post < ApplicationRecord
	
	# associations
	belongs_to :user

	# validations
	validates_presence_of :content

end
