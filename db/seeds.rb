# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#puts 'SETTING UP ADMIN USER LOGIN'
#if User.find_by_email('admin@humblecasa.com').nil?
#	user = User.create! :first_name => 'Admin', :last_name => 'User', :email => 'admin@humblecasa.com', :password => '4INFO4life', 
#					:password_confirmation => '4INFO4life', :role => :admin, :primary_phone => 4444444444
#	puts 'New user created: ' << user.first_name
#else
#	puts 'Admin already exists'
#end
puts 'CREATING SERVICE CATEGORIES'
Category::CATEGORIES.each do |name|
	if Category.find_by_name(name).nil?
		cat = Category.create! :name => name
		puts 'Category created: ' << cat.name
	end
end