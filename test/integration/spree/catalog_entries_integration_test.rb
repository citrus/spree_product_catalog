require "test_helper"

class Spree::CatalogEntriesIntegrationTest < ActiveSupport::IntegrationCase
  
  def setup
    Spree::CatalogEntry.destroy_all
    @image = File.expand_path("../../../support/files/1.jpg", __FILE__)
    @pdf   = File.expand_path("../../../support/files/test.pdf", __FILE__)
    @entry = Spree::CatalogEntry.create(:title => "OMG Entry!", :image => File.open(@image), :pdf => File.open(@pdf))
    @product = Factory(:product)
  end
  
  should "get the catalog entries index" do
    visit spree.catalog_entries_path
    assert_seen @entry.title
    assert has_xpath?("//img[@src='#{@entry.image.url(:small)}']")
  end
  
  should "get the catalog entry show page" do
    visit spree.catalog_entry_path(@entry)
    assert_seen @entry.title
    assert has_xpath?("//img[@src='#{@entry.image.url(:large)}']")
    assert has_xpath?("//a[@href='#{@entry.pdf.url}']")
  end
  
  should "show products linked to catalog entry" do
    @entry.products << @product
    visit spree.catalog_entry_path(@entry)
    assert_seen @product.name
  end
  
end
