require "test_helper"

class Spree::CatalogEntryTest < ActiveSupport::TestCase
  
  should have_and_belong_to_many(:products)
  
end
