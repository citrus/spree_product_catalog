class Spree::CatalogEntry < ActiveRecord::Base

  has_and_belongs_to_many :products, :join_table => "spree_catalog_entries_products"

end
