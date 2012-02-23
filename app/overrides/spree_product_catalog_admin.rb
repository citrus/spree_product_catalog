Deface::Override.new(:virtual_path  => "spree/layouts/admin", 
                     :name          => "spree_product_catalog_admin_tab", 
                     :insert_bottom => "ul[data-hook='admin_tabs']",
                     :partial       => "spree/admin/shared/catalog_entries_tab",
                     :disabled      => !SpreeProductCatalog.independent?)
                     
