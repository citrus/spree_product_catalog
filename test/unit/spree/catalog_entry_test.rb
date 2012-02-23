require "test_helper"

class Spree::CatalogEntryTest < ActiveSupport::TestCase
  
  should have_and_belong_to_many(:products)
  
  should have_attached_file(:image)
  should have_attached_file(:pdf)
  
  should validate_presence_of(:title)
  should validate_presence_of(:permalink)
  
  should validate_attachment_content_type(:pdf).allowing('application/pdf').rejecting('image/png', 'image/gif', 'text/plain', 'text/xml')
  
  context "A new, unsaved catalog entry" do
    
    setup do
      @entry = Spree::CatalogEntry.new(:title => "Just an entry!")
    end
    
    should "create permalink unless it exists" do
      @entry.title = "OMG auto-permalinkability!"
      @entry.permalink = ""
      assert @entry.valid?
      assert_equal "omg-auto-permalinkability", @entry.permalink
    end
    
  end
  
  context "An existing catalog entry" do
    
    setup do
      @entry = Spree::CatalogEntry.create(:title => "Just an entry!")
    end    
    
    should "return use permalink as to_param" do
      assert_equal @entry.permalink, @entry.to_param
    end
    
  end
  
end
