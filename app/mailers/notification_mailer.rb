class NotificationMailer < ActionMailer::Base
	default from: "support@humblecasa.com"
  
  	def new_service(service)
		@service = service
		mail to: "jason@humblecasa.com", subject: "New service signed-up: " + @service.name
	end

	def new_user(user)
		@user = user
		mail to: "jason@humblecasa.com", subject: "New " + @user.role + " user signed-up"
	end

	def welcome(user)
		@user = user
		mail to: @user.email, subject: "Welcome to HumbleCasa!"
	end

	def new_employee(user)
		@user = user
		@service = @user.employer
		mail to: @user.email, subject: @service.name + " has created an account for you on HumbleCasa.com!"
	end

	def password_reset(user)
		@user = user
		mail to: @user.email, subject: "Reset password for HumbleCasa.com"
	end

	def signup(assignment)
		@service = assignment.service
    	@property = assignment.property
    	
    	mail to: @service.email, subject: @service.name + ": You have a new customer waiting on HumbleCasa.com!"
  	end

end
