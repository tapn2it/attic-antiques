ActionController::Routing::Routes.draw do |map|
  # Loads all extension routes in the order they are specified.
  map.load_extension_routes

  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  # map.connect '', :controller => "welcome"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # map.connect '/locale/:new_locale', :controller => 'locale', :action => 'set_session_locale'

  map.root :controller => "products", :action => "index"
  # login mappings should appear before all others
  map.login '/login', :controller => 'account', :action => 'login'
  map.logout '/logout', :controller => 'account', :action => 'logout'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.admin '/admin', :controller => 'admin/overview', :action => 'index'  

  map.resources :tax_categories
  map.resources :countries, :has_many => :states, :actions => [:index]
  map.resources :states, :actions => [:index]
  map.resources :users
  map.resources :products, :member => {:change_image => :post}
  map.resources :addresses
  map.resources :orders, :member => {:address_info => :get, :checkout => :get}, :has_many => :line_items, :has_one => [:address, :creditcard_payment]

  # route globbing for pretty nested taxon and product paths
  map.taxons_with_product '/t/*taxon_path/p/:id', :controller => 'products', :action => 'show'
  map.nested_taxons '/t/*id', :controller => 'taxons', :action => 'show'
  
  #moved old taxons route to after nested_taxons so nested_taxons will be default route
  #this route maybe removed in the near future (no longer used by core)
  map.resources :taxons
  
  map.namespace :admin do |admin|
    admin.resources :zones
    admin.resources :users
    admin.resources :countries, :has_many => :states
    admin.resources :states
    admin.resources :tax_categories
    admin.resources :configurations
    admin.resources :products, :has_many => [:variants, :images, :product_properties] do |product|
      product.resources :option_types, :member => {:select => :get, :remove => :get}, :collection => {:available => :get, :selected => :get}
      product.resources :taxons, :member => {:select => :post, :remove => :post}, :collection => {:available => :post, :selected => :get}
    end
    admin.resources :images
    admin.resources :option_types
    admin.resources :properties, :collection => {:filtered => :get}
    admin.resources :prototypes, :member => {:select => :post}, :collection => {:available => :get}
    admin.resource :mail_settings
    admin.resource :inventory_settings
    admin.resource :general_settings
    admin.resources :orders, :member => {:fire => :put, :resend => :post}
    admin.resources :taxonomies do |taxonomy|
      taxonomy.resources :taxons
    end
  end
  
  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'

  # a catchall route for "static" content
  map.connect '*path', :controller => 'content', :action => 'show'

end
