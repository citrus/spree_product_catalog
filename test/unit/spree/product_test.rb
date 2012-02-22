require "test_helper"

class Spree::ProductTest < ActiveSupport::TestCase
  
  should have_and_belong_to_many(:catalog_entries)
  
end
