class Category < ActiveRecord::Base
	attr_accessible :name

	has_and_belongs_to_many :services

	CATEGORIES = %w[chimney_services handyman/general_maintenance housecleaning landscaping pest_control pool/spa_cleaning snow_removal ]
    #also need to update Services form if changing categories

end
