Spree::Core::Engine.routes.append do

  namespace :admin do  
    resources :catalog_entries do
      get "link/:product_id/:behavior", :action => :link, :as => :product
    end
  end

  resources :catalog_entries, :path => "product-catalog"

end
