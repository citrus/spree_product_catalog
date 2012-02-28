class Spree::CatalogEntriesController < Spree::BaseController

  def index
    @catalog_entries = Spree::CatalogEntry.order(:position).all
  end

  def show
    @catalog_entry = Spree::CatalogEntry.find_by_permalink(params[:id])
    @products = @catalog_entry.products
  end

end
