class CustomersReport < Dossier::Report

  def sql
    'SELECT 
      Users.first_name,
      Users.last_name,
      Users.email,
      Users.primary_phone,
      Properties.name,
      Properties.address1,
      Properties.address2,
      Properties.city,
      Properties.state,
      Properties.zip,
      Properties.phone,
      Assignments.category
    FROM Properties
    INNER JOIN Assignments
    ON Properties.id=Assignments.property_id
    AND Assignments.service_id=:service
    INNER JOIN Users
    ON Properties.user_id=Users.id' 
  end

  def service
  	@service ||= options.fetch(:service_id)
  end

  def format_header(column_name)
    custom_headers = {
      name: 'Property Name',
      phone:   'Property Phone #'
    }
    custom_headers.fetch(column_name.to_sym) { super }
  end

  def format_category(value)
    return value.humanize
  end

end