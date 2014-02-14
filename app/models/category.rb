class Category < ActiveRecord::Base
	attr_accessible :name

	has_and_belongs_to_many :services

	CATEGORIES = %w[chimney_services handyman/general_maintenance housecleaning landscaping pest_control pool/spa_cleaning snow_removal caretaking window_washing]

    CATEGORY_DESCRIPTIONS = [
        ['Chimney cleaning, seasonal check-up, or fixing any issues', 'chimney_services'],
        ['No job too big or too small!', 'handyman/general_maintenance'],
        ['Schedule on-going cleanings or one-time before/after rentals', 'housecleaning'],
        ['Mowing, raking, watering, pruning, or brush clearing', 'landscaping'],
        ['Keep your house free of mice, ants, and termites', 'pest_control'],
        ['Cleaning, maintance, or seasonal closing/opening', 'pool/spa_cleaning'],
        ['Make sure your driveway is plowed before you come up for the weekend!', 'snow_removal'],
        ['Have someone check on your house while you are away', 'caretaking'],
        ['Have a professional clean your hard-to-reach windows', 'window_washing']
    ]


end
