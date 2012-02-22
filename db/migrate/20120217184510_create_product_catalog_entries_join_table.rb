class CreateProductCatalogEntriesJoinTable < ActiveRecord::Migration

  def self.up
    create_table :spree_catalog_entries_products, :id => false do |t|
      t.references :catalog_entry
      t.references :product
    end
    add_index :spree_catalog_entries_products, :catalog_entry_id
    add_index :spree_catalog_entries_products, :product_id
  end

  def self.down
    drop_table :spree_catalog_entries_products
  end
  
end
