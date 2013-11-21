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
end
