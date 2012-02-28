Spree::Core::Engine.routes.append do

  namespace :admin do  
    resources :catalog_entries do
      get "link/:product_id/:behavior", :action => :link, :as => :product
    end
  end

  get "/product-catalog" => "catalog_entries#index", :as => :catalog_entries

end
