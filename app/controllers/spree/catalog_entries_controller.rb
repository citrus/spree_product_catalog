class Spree::CatalogEntriesController < Spree::BaseController

  def index
    @catalog_entries = Spree::CatalogEntry.order(:position).page(params[:page]).per(Spree::Config[:products_per_page])
  end

  def show
    @catalog_entry = Spree::CatalogEntry.find_by_permalink(params[:id])
    @products = @catalog_entry.products.page(params[:page]).per(Spree::Config[:products_per_page])
  end

end
