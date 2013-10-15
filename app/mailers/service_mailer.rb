class ServiceMailer < ActionMailer::Base
  default from: "jason@humblecasa.com"
  require 'icalendar'
  require 'date'
  include Icalendar


  def service_created(service_request)
    @service_request = service_request
    @service = @service_request.service
    @property = @service_request.property

    if User.find_by_id(@service.user_id).notify?
      mail to: @service.email, subject: "New service request"
    end
  end
 
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

  def service_scheduled(service_request)
    if service_request.property.user.notify?
        createEventandMail(service_request.property.user.email, service_request, 
          "Service request scheduled", service_request.service.name + ": service for " + service_request.property.name)
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

  def createEventandMail(email, sr, subject, summary)
    @service_request = sr
    @service = @service_request.service
    @property = @service_request.property    
    
    @start = DateTime.parse(sr.first_scheduled.to_s).in_time_zone(sr.property.time_zone)
    @end = DateTime.parse((sr.first_scheduled + sr.duration.hours).to_s).in_time_zone(sr.property.time_zone)

    ical = Icalendar::Calendar.new
    e = Icalendar::Event.new
    e.start       @start
    e.end         @end
    e.summary     summary
    ical.add_event(e)
    ical.publish
    ical.to_ical

    attachments['event.ics'] = { 
      :mime_type => 'text/calendar', 
      :content => ical.to_ical 
    }
       
    mail to: email, subject: subject
  end

end
