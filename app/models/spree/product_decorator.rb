Spree::Product.class_eval do

  has_and_belongs_to_many :catalog_entries, :join_table => "spree_catalog_entries_products"

end
