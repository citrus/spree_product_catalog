Spree::Core::Engine.routes.append do

  namespace :admin do  
    resources :catalog_entries  
  end

end
