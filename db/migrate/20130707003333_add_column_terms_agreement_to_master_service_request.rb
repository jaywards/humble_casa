class AddColumnTermsAgreementToMasterServiceRequest < ActiveRecord::Migration
  def change
    add_column :master_service_requests, :terms_agreement, :boolean
  end
end
