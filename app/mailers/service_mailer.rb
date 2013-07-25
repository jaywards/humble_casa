class ServiceMailer < ActionMailer::Base
  default from: "jason@humblecasa.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.service_mailer.service_created.subject
  #
  def service_created(service_request)
    @service_request = service_request
    @service = @service_request.service
    @property = @service_request.property

    if User.find_by_id(@service.user_id).notify?
      mail to: @service.email, subject: "New service request"
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.service_mailer.service_completed.subject
  #
 
  def service_assigned(service_request)
    @service_request = service_request
    @service = @service_request.service
    @property = @service_request.property
    
    if @service_request.user.notify?
      if @service_request.user == User.find_by_id(@service.user_id)
        mail to: @service_request.service.email, subject: "Service request assigned"
      else          
        mail to: @service_request.user.email, subject: "Service request assigned"
      end
    end
  end


  def service_completed(service_request)
    @service_request = service_request
    @service = @service_request.service
    @property = @service_request.property

    if @property.user.notify?
      mail to: @property.user.email, subject: "Service request completed"
    end
  end
end
