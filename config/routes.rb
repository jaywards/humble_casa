HumbleCasa::Application.routes.draw do
  resources :user_sessions
  
  resources :users do
    resources :properties, :services, :service_zips
  end
  
  resources :properties do
    member do
      get 'assign_services'
      get 'show_property'
    end
  end
  
  resources :services do
    member do
      get 'approve_employee'
    end
    resources :properties do
      resources :master_service_requests, only: [:new, :edit]
      resources :service_requests do
        member do
          get 'view_completed'
        end
      end
    end
  end
  
  resources :master_service_requests, only: [:update, :index, :show, :create, :destroy] do
    member do
      get 'pause'
    end
  end

  resources :service_requests do
    member do
      get 'assign_to_employee'
      get 'complete_request'
      get 'schedule_request'
    end
  end
  
  match '/login', to: 'user_sessions#new', :as => :login
  match '/logout', to: 'user_sessions#destroy', :as => :logout
  match '/new_user', to: 'users#new', :as => :new_user
  match '/business', to: 'static_pages#business', :as => :business
  match '/pricing_plans', to: 'static_pages#pricing_plans', :as => :pricing_plans
  match '/feature_tour', to: 'static_pages#feature_tour', :as => :feature_tour

  root to: 'static_pages#home'

  get "static_pages/home"
  get "static_pages/help"
  get "static_pages/about"
  get "static_pages/pricing_plans"
  get "static_pages/feature_tour"
  get "static_pages/contact_us"
  get "static_pages/careers"
  get "static_pages/business"
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
