class Assignment < ActiveRecord::Base
  attr_accessible :category, :property_id, :service_id, :interested, :confirmed, :cost, :note

  belongs_to :service
  belongs_to :property

  def invoiced_this_month
  	if !self.last_invoice_date.nil? && self.last_invoice_date >= Date.today.beginning_of_month && self.last_invoice_date <= Date.today.end_of_month
  		true
  	else
  		false
  	end
  end

  def create_customer(card_token)
    if valid?
      customer = Stripe::Customer.create(
        {description: self.property.name_with_owner, card: card_token}, 
        self.service.stripe_access_token
      )
      self.stripe_customer_token = customer.id
      save!
    end
    rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

  def update_customer(card_token)
    if valid?
      customer = Stripe::Customer.retrieve(stripe_customer_token)
      customer.card = card_token
      customer.save  
    end
    rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while updating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

end
