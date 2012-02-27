Spree::Core::Engine.routes.append do

  namespace :admin do  
    resources :catalog_entries
  end

  get "/product-catalog" => "catalog_entries#index", :as => :catalog_entries

end
