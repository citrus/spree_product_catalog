require "spree_core"
require "spree_product_catalog/version"
require "spree_product_catalog/engine"

module SpreeProductCatalog
  
  def self.tab
    { :label => 'Product Catalog', :route => :admin_product_catalog_entries }
  end
  
  def self.sub_tab
    [:product_catalog, { :route => :admin_product_catalog_entries, :label => 'spree.admin.subnav.product_catalog', :match_path => '/catalog_entries' }]
  end
  
  def self.independent?
    return true unless defined?(SpreeEssentials)
    !SpreeEssentials.respond_to?(:register)
  end
    
end

unless SpreeProductCatalog.independent?
  SpreeEssentials.register :press, SpreeProductCatalog 
end
