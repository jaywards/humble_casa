class ServiceRequestsReport < Dossier::Report

  def sql
    'SELECT 
      Service_requests.completed,
      Service_requests.completed_date,
      Service_requests.onetime,
      Service_requests.charge,
      Properties.name,
      Properties.address1,
      Properties.city,
      Users.first_name,
      Users.last_name
    FROM Service_requests,Properties,Users
    WHERE Service_requests.service_id=:service
    AND Service_requests.completed=:completed_requests
    AND Service_requests.completed_date>=:report_start_date
    AND Service_requests.completed_date<=:report_end_date
    AND Properties.id=Service_requests.property_id
    AND Users.id=Properties.user_id'
  end

  def service
  	@service ||= options.fetch(:service_id)
  end

  def report_start_date
    @report_start_date ||= options.fetch(:report_start_date)
  end

  def report_end_date
    @end_date ||= options.fetch(:report_end_date)
  end

  def completed_requests
    @completed ||= options.fetch(:completed_requests)
  end

  def format_header(column_name)
    custom_headers = {
      name: 'Property Name',
      phone:   'Property Phone #',
      first_name: 'Owner First Name',
      last_name: 'Owner Last Name',
      onetime: 'Request Type',
      completed: 'Status'
    }
    custom_headers.fetch(column_name.to_sym) { super }
  end

  def format_charge(value, row)
    return "" if row[:completed] == 'f'
    formatter.number_to_currency(value)
  end

  def format_completed_date(value, row)
    if row[:completed] == 'f'
      return "N/A"
    else
      return Date.parse(value).strftime('%m/%d/%Y')
    end
  end

  def format_completed(value)
    if value == 't'
      return "Completed"
    else
      return "Open"
    end
  end

  def format_onetime(value)
    if value == 't'
      return "One-time request"
    else
      return "Repeating"
    end
  end

end