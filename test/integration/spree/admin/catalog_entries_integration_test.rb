require "test_helper"

class Spree::Admin::CatalogEntriesIntegrationTest < ActiveSupport::IntegrationCase
  
  def setup
    Spree::CatalogEntry.destroy_all
    @image = File.expand_path("../../../../support/files/1.jpg", __FILE__)
    @pdf   = File.expand_path("../../../../support/files/test.pdf", __FILE__)
  end
  
  should "get the catalog entries index" do
    visit spree.admin_catalog_entries_path
    assert has_link?("New Catalog Entry")
    assert_seen "Listing Catalog Entries"
  end
  
  should "paginate the catalog entries index" do
    Spree::Config.set(:orders_per_page => 2)
    1.upto(3) { |i|
      Spree::CatalogEntry.create(:title => "Entry ##{i}", :position => i)
    }
    visit spree.admin_catalog_entries_path
    within ".pagination" do
      assert has_link?("2")
      click_link "2"
    end
    assert_seen "Entry #3", :within => "table.index"
    assert_match /page\=2/, current_url
  end
  
  should "create an catalog entry" do
    visit spree.admin_catalog_entries_path
    click_link "New Catalog Entry"
    fill_in "Title", :with => "Just an entry"
    attach_file "Image", @image
    click_button "Create"
    assert_equal spree.admin_catalog_entries_path, current_path
    assert_flash "Catalog entry has been successfully created!"
  end
  
  context "with an existing catalog entry" do
  
    setup do 
      @catalog_entry = Spree::CatalogEntry.create(:title => "Just an entry!", :image => File.open(@image))
    end
  
    should "display the index" do
      visit spree.admin_catalog_entries_path
      assert_seen @catalog_entry.title, :within => "tr#spree_catalog_entry_#{@catalog_entry.id}"
      within "td.actions" do
        assert find("a.icon_link").native.attribute("href").include?(spree.edit_admin_catalog_entry_path(@catalog_entry))
        assert has_selector?("a[href='#']")
      end
    end
    
    should "edit the catalog entry" do
      visit spree.edit_admin_catalog_entry_path(@catalog_entry)
      assert_seen "Preview", :within => ".edit_spree_catalog_entry p b"
      assert has_xpath?("//img[@src='#{@catalog_entry.image.url(:small)}']")
      fill_in "Title", :with => "Just another image"
      click_button "Update"
      assert_equal spree.admin_catalog_entries_path, current_path
      assert_flash "Catalog entry has been successfully updated!"
    end
    
    should "destroy the catalog entry" do
      visit spree.admin_catalog_entries_path
      find(".actions a[href='#']").click
      find_by_id("popup_ok").click              
    end
    
    context "with an existing product" do
      
      setup do
        @product = Factory(:product)
      end
      
      should "add a linked product" do
        @catalog_entry.products.destroy_all
        visit spree.edit_admin_catalog_entry_path(@catalog_entry)
        assert_difference "@catalog_entry.products.reload.count", +1 do
          within "#unlinked-products" do
            click_link "+"
          end
        end
      end
      
      should "fail to link product when product not found" do
        assert_no_difference "@catalog_entry.products.reload.count" do
          visit spree.admin_catalog_entry_product_path(@catalog_entry, "non-existent-product", "add")   
        end
        assert_equal spree.edit_admin_catalog_entry_path(@catalog_entry), current_path
      end
      
      should "remove a linked product" do
        @catalog_entry.products = [ @product ]
        visit spree.edit_admin_catalog_entry_path(@catalog_entry)
        assert_difference "@catalog_entry.products.reload.count", -1 do
          within "#linked-products" do
            click_link "x"
          end
        end
      end
            
      should "fail to unlink product when product not found" do
        assert_no_difference "@catalog_entry.products.reload.count" do
          visit spree.admin_catalog_entry_product_path(@catalog_entry, "non-existant-product", "remove")
        end
        assert_equal spree.edit_admin_catalog_entry_path(@catalog_entry), current_path
      end
    
    end
        
  end
  
end
