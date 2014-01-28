class PaymentsReport < Dossier::Report
  def sql
    'SELECT 
      Service_requests.charge_date,
      Service_requests.charge,
      Properties.name,
      Properties.address1,
      Properties.city,
      Users.first_name,
      Users.last_name
    FROM Service_requests,Properties,Users
    WHERE Service_requests.service_id=:service
    AND Service_requests.completed=:completed
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

  def completed
    true
  end

  def format_header(column_name)
    custom_headers = {
      name: 'Property Name',
      first_name: 'Owner First Name',
      last_name: 'Owner Last Name',
    }
    custom_headers.fetch(column_name.to_sym) { super }
  end

  def format_charge(value, row)
    return "" if row[:completed] == 'f'
    formatter.number_to_currency(value)
  end

  def format_charge_date(value, row)
    if row[:completed] == 'f'
      return "N/A"
    else
      return Date.parse(value).strftime('%m/%d/%Y')
    end
  end

end