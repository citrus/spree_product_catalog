class Spree::Admin::CatalogEntriesController < Spree::Admin::ResourceController
  
  before_filter :get_unlinked_products, :only => :edit
  
  def link
    @catalog_entry = Spree::CatalogEntry.find_by_permalink(params[:catalog_entry_id])
    @product = Spree::Product.find_by_permalink(params[:product_id])    
    if @product.nil?
      flash.alert = "Product not found!"
    else
      case params[:behavior]
        when "add";    @catalog_entry.products << @product
        when "remove"; @catalog_entry.products.delete(@product)
      end
      return render(:partial => "spree/admin/catalog_entries/link", :locals => { :action => opposite_behavior, :product => @product }) if request.xhr?
      set_flash_message(params[:behavior])
    end
    redirect_to edit_admin_catalog_entry_path(@catalog_entry)
  end
  
  def update_positions
    params[:positions].each do |id, index|
      Spree::CatalogEntry.where(:id => id).update_all(:position => index)
    end
    respond_to do |format|
      format.html { redirect_to admin_catalog_entries_url }
      format.js  { render :text => 'Ok' }
    end
  end
      
private

  def location_after_save
    if params[:action] == "create"
      edit_object_url(@catalog_entry)
    else
      collection_url
    end
  end
  
  def opposite_behavior
    params[:behavior] == "add" ? "remove" : "add"
  end
  
  def set_flash_message(verb)
    verb = case verb
      when "add"; "added to"
      when "remove"; "removed from"
    end
    flash.notice = "#{@product.name} successfully #{verb} #{@catalog_entry.title}."
  end
  
  def get_unlinked_products
    scope = Spree::Product.select('id, name, permalink')
    scope = scope.where('id NOT IN (?)', load_resource.products.map(&:id)) unless load_resource.products.empty?
    @products = scope.all
  end
  
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
