StripeEvent.setup do
  
  subscribe 'charge.succeeded' do |event|
      @data = event.data.object.metadata
      @service = Service.find_by_id(@data[:service_id])
      @property = Property.find_by_id(@data[:property_id])
      @service_request = ServiceRequest.find_by_id(@data[:service_request_id])
    
      if @data[:type] == 'to_property'
        @assignment = Assignment.find_by_service_id_and_property_id(@service.id, @property.id)  
        if !@assignment.invoiced_this_month
          @invoice_item = Stripe::InvoiceItem::create(
            customer: @service.stripe_customer_token, 
            amount: 100, 
            currency: "usd", 
            description:  "Active customer (" + @property.name + " / " +  
              @property.user.full_name + ") charge for " + Date::MONTHNAMES[Date.today.month], 
            metadata: {
              'type' => 'to_service', 
              'service_id' => @service.id.to_s, 
              'property_id' => @property.id.to_s, 
              'month' => Date.today.month.to_s,
              'service_request_id' => @service_request.id.to_s 
            }
          )
          @assignment.last_invoice_date = Date.today
          @assignment.save!
        end
        
        #@completion_date = DateTime.parse(@service_request.completed_date.to_s).in_time_zone(@property.time_zone).strftime("%m/%d/%Y")
        #@charge = number_to_currency(@service_request.charge)
        #@pending_transfer = Stripe::Transfer::create(
        #  amount: BigDecimal(@service_request.charge * 100 * .971).round - 55,
        #  currency: "usd",
        #  recipient: @service.stripe_recipient_token,
        #  description: "Transfer " + @charge + " minus fees. For work on " + @property.name + " / " +  
        #    @property.user.full_name + ". Completed on " + @completion_date + " by " + @service_request.user.full_name, 
        #  statement_descriptor: @service_request.service_request_id
        #  metadata: {
        #    'type' => 'to_service', 
        #    'service_id' => @service.id.to_s, 
        #    'property_id' => @property.id.to_s, 
        #    'service_request_id' => @service_request.id.to_s 
        #  }
        #)

      end
  end

end