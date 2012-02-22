# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spree_product_catalog/version"

Gem::Specification.new do |s|
  
  s.name        = "spree_product_catalog"
  s.version     = SpreeProductCatalog::VERSION
  s.authors     = ["Spencer Steffen"]
  s.email       = ["spencer@citrusme.com"]
  s.homepage    = "https://github.com/citrus/spree_product_catalog"
  s.summary     = %q{Spree Product Catalog adds an introduction and overview page for products in your line.}
  s.description = %q{Spree Product Catalog adds an introduction and overview page for products in your line.}

  s.rubyforge_project = "spree_product_catalog"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # Spree
  s.add_dependency('spree_core', '~> 1.0.0')
  
  # Development
	s.add_development_dependency('shoulda',      '~> 3.0.0.beta2')
	s.add_development_dependency('dummier',      '~> 0.3.0')
	s.add_development_dependency('factory_girl', '~> 2.5.2')
	s.add_development_dependency('capybara',     '~> 1.1.2')
	s.add_development_dependency('sqlite3',      '~> 1.3.5')
	
end
