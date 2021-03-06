# Spree Product Catalog

### under construction

Installation
------------

Add spree_product_catalog to your project's Gemfile:

```ruby
gem "spree_product_catalog"
```

Then install!

```bash
bundle install
rake spree_product_catalog:install:migrations
```


In production mode, make sure `admin/catalog_entry.css` is added to the asset precompile list:

```ruby
# config/application.rb
module MySpreeStore
  class Application < Rails::Application
  
    config.assets.precompile += %w(admin/catalog_entry.css)

  end
end
```


------------------------------------------------------------------------------
Testing
------------------------------------------------------------------------------

Clone this repo to where you develop, bundle up, then run `dummier' to get the show started:

```bash
git clone git://github.com/citrus/spree_product_catalog.git
cd spree_product_catalog
bundle install
bundle exec dummier
rake 
```


------------------------------------------------------------------------------
Demo
------------------------------------------------------------------------------

You can easily use the test/dummy app as a demo of spree_product_catalog. Just `cd` to where you develop and run:

```bash
git clone git://github.com/citrus/spree_product_catalog.git
cd spree_product_catalog
cp test/dummy_hooks/after_migrate.rb.sample test/dummy_hooks/after_migrate.rb
bundle install
bundle exec dummier
cd test/dummy
ruby script/rails server
```


License
-------

Copyright (c) 2011 - 2012 Spencer Steffen & Citrus, released under the New BSD License All rights reserved.
