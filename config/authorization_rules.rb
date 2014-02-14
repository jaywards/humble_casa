authorization do
  role :admin do
    has_permission_on [:users, :user_sessions, :static_pages], :to => [:index, :show, :new, :create, :edit, 
      :update, :destroy]
    has_permission_on :services, :to => [:index, :show, :new, :create, :edit, :update, :destroy, 
      :provide_estimate, :rate, :add_payment_info, :edit_payment_info, :update_with_card, :add_bank_account, 
      :edit_bank_account, :save_with_account, :add_employee, :create_employee]
    has_permission_on :properties, :to => [:index, :show, :new, :create, :edit, :update, :destroy, 
      :view_completed, :assign_services, :confirm_assignment, :add_payment_info, :edit_payment_info, :update_with_card,
      :update_with_assignments]
    has_permission_on :users, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :update_referral_list]
    has_permission_on :master_service_requests, :to => [:new, :create, :show, :edit, :update, :destroy, :pause]
    has_permission_on :service_requests, :to => [:show, :destroy, :view_completed, :index, :complete_request, 
      :assign_to_employee, :update, :show]
  end
  
  role :guest do
    has_permission_on [:users, :user_sessions], :to => [:new, :create, :destroy]
    has_permission_on [:static_pages], :to => :show
  end
  
  role :standard_user do
    has_permission_on :users, :to => [:show, :edit, :update]
  end  


  role :propertyowner do
    includes :guest
    has_permission_on :users, :to => [:show, :edit, :update, :update_referral_list]
    has_permission_on :properties, :to => [:new, :create, :show, :edit, :update, :destroy, :assign_services, 
      :confirm_assignment, :add_payment_info, :edit_payment_info, :update_with_card, :update_with_assignments]
    has_permission_on :master_service_requests, :to => [:new, :create, :show, :edit, :update, :destroy, :pause]
    has_permission_on :service_requests, :to => [:show, :edit, :update, :destroy, :pausem, :view_completed]
    has_permission_on :user_sessions, :to => [:destroy, :new, :create]
    has_permission_on :services, :to => [:show, :rate]
  end
  
  role :serviceowner do
    includes :guest
    has_permission_on :users, :to => [:show, :edit, :update]
    has_permission_on :user_sessions, :to => [:destroy, :new, :create]
    has_permission_on :services, :to => [:new, :create, :show, :edit, :update, :destroy, :provide_estimate, 
      :add_payment_info, :edit_payment_info, :update_with_card, :add_bank_account, :edit_bank_account, 
      :save_with_account, :add_employee, :create_employee]
    has_permission_on :master_service_requests, :to => [:new, :create, :show, :edit, :update, :destroy, :pause]
    has_permission_on :service_requests, :to => [:complete_request, :assign_to_employee, :update, :show]
    has_permission_on :properties, :to => [:new, :create, :show]
  end

  role :employee do
    includes :guest
    includes :standard_user
    has_permission_on :properties, :to => [:view_completed, :show_property]
    has_permission_on :service_requests, :to => [:complete_request, :update]

  end

end