class CustomersReport < Dossier::Report

  def sql
   #Property.where(zip: zip_code).to_sql

   'SELECT name,address1,address2,city,state,zip,phone
   FROM Properties
   INNER JOIN Assignments
   ON Properties.id=Assignments.property_id
   AND Assignments.service_id=:service'
  end

  def service
  	@service ||= options.fetch(:service_id)
  end

end