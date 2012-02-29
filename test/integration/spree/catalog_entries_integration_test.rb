require "test_helper"

class Spree::CatalogEntriesIntegrationTest < ActiveSupport::IntegrationCase
  
  def setup
    Spree::CatalogEntry.destroy_all
    @image = File.expand_path("../../../support/files/1.jpg", __FILE__)
    @pdf   = File.expand_path("../../../support/files/test.pdf", __FILE__)
    @entry = Spree::CatalogEntry.create(:title => "OMG Entry!", :image => File.open(@image), :pdf => File.open(@pdf))
    @product = Factory(:product)
  end
  
  should "get index and paginate catalog entries" do
    1.upto(3) {|i|
      Spree::CatalogEntry.create(:title => "Entry ##{i}!")  
    }
    Spree::Config.set(:products_per_page => 2)
    visit spree.catalog_entries_path
    within ".catalog-entry" do
      assert_seen @entry.title
      assert has_xpath?("//img[@src='#{@entry.image.url(:small)}']")
    end
    within ".pagination" do
      assert has_link?("2")
      click_link "2"
    end
    assert_seen "Entry #3!"
    assert_match /page\=2/, current_url
  end
  
  should "get the catalog entry show page" do
    visit spree.catalog_entry_path(@entry)
    assert_seen @entry.title
    assert has_xpath?("//img[@src='#{@entry.image.url(:large)}']")
    assert has_xpath?("//a[@href='#{@entry.pdf.url}']")
  end
  
  should "show and paginate products linked to catalog entry" do
    3.times {
      @entry.products << Factory(:product)
    }
    visit spree.catalog_entry_path(@entry)
    assert_seen @entry.title, :within => "#content h2"
    assert_seen  @entry.products.first.name, :within => "#products"
    within ".pagination" do
      assert has_link?("2")
      click_link "2"
    end
    assert_seen @entry.products.last.name, :within => "#products"
  end
  
end
