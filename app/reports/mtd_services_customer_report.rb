class MTDServicesCustomerReport < Dossier::Report

  def sql
   'SELECT *
   FROM Service_Requests
   WHERE
   completed_date > :startdate
   AND
   service_id = :service
   AND
   completed = t'
  end

  def service
  	@service ||= options.fetch(:service_id)
  end

  def startdate
    @start = Date.today.at_beginning_of_month
  end

end