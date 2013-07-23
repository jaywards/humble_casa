authorization do
  role :admin do
    has_permission_on [:users, :user_sessions, :static_pages, :services, :master_service_requests], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :services, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :approve_employee]
    has_permission_on :properties, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :view_completed, :assign_services]
    has_permission_on :users, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :assign_employment]
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
    has_permission_on :users, :to => [:show, :edit, :update]
    has_permission_on :properties, :to => [:new, :create, :show, :edit, :update, :destroy, :assign_services, :view_completed]
    has_permission_on :master_service_requests, :to => [:new, :create, :show, :edit, :update, :destroy]
    has_permission_on :user_sessions, :to => [:destroy, :new, :create]
  end
  
  role :serviceowner do
    includes :guest
    has_permission_on :users, :to => [:show, :edit, :update]
    has_permission_on :user_sessions, :to => [:destroy, :new, :create]
    has_permission_on :services, :to => [:new, :create, :show, :edit, :update, :destroy, :approve_employee]
    has_permission_on :master_service_requests, :to => [:new, :create, :show, :edit, :update, :destroy]
  end

  role :employee do
    includes :guest
    includes :standard_user
    has_permission_on :users, to: [:assign_employment]

  end

end