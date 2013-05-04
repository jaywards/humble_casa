authorization do
  role :admin do
    has_permission_on [:users, :properties, :user_sessions, :static_pages, :services], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end
  
  role :guest do
    has_permission_on [:users, :user_sessions], :to => [:new, :create, :destroy]
    has_permission_on [:static_pages], :to => :show
  end
  
  role :propertyowner do
    has_permission_on :users, :to => [:show, :edit, :update] #do
#      if_attribute :user =>  is { user }
#    end
    has_permission_on :properties, :to => [:new, :create, :show, :edit, :update, :destroy] #do
    #  if_attribute :user => is { user }
    #end
    has_permission_on :user_sessions, :to => [:destroy, :new, :create]
  end
  
  role :serviceowner do
    includes :guest
    has_permission_on :users, :to => [:show, :edit, :update]
    has_permission_on :user_sessions, :to => [:destroy, :new, :create]
    has_permission_on :services, :to => [:new, :create, :show, :edit, :update, :destroy]
  end

  role :employee do
    includes :guest
  end

end