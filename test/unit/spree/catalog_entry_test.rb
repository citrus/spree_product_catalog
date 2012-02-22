require "test_helper"

class Spree::CatalogEntryTest < ActiveSupport::TestCase
  
  should have_and_belong_to_many(:products)
  
  should have_attached_file(:image)
  should have_attached_file(:pdf)
  
  should validate_presence_of(:title)
  should validate_presence_of(:permalink)
  
  should validate_attachment_content_type(:pdf).allowing('application/pdf').rejecting('image/png', 'image/gif', 'text/plain', 'text/xml')
  
end
