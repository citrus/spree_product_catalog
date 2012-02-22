class CreateProductCatalogEntries < ActiveRecord::Migration

  def self.up
    create_table :spree_catalog_entries do |t|
      t.string    :title
      t.string    :permalink
      t.string    :teaser
      t.text      :body
      
      # paperclip image
      t.string     :image_file_name,    :default => nil
	    t.string     :image_content_type, :default => nil
	    t.string     :image_file_size,    :default => nil
	    t.datetime   :image_updated_at,   :default => nil
	    
      # paperclip pdf
      t.string     :pdf_file_name,    :default => nil
	    t.string     :pdf_content_type, :default => nil
	    t.string     :pdf_file_size,    :default => nil
	    t.datetime   :pdf_updated_at,   :default => nil
      
      t.integer   :position, :null => false, :default => 0
      
      t.timestamps
    end        
  end

  def self.down
    drop_table :spree_catalog_entries
  end
  
end
