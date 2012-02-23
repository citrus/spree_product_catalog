class Spree::Admin::CatalogEntriesController < Spree::Admin::ResourceController
  
  private
   
    def find_resource
      Spree::CatalogEntry.find_by_permalink(params[:id])
    end
   
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "position.asc"
      @search = Spree::CatalogEntry.metasearch(params[:search])
      @collection = @search.page(params[:page]).per(Spree::Config[:orders_per_page])
    end

end
