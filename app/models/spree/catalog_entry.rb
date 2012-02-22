class Spree::CatalogEntry < ActiveRecord::Base

  has_and_belongs_to_many :products, :join_table => "spree_catalog_entries_products"

  has_attached_file :image
  has_attached_file :pdf
  
  validates :title, :permalink, :presence => true
  validates :teaser, :length => { :maximum => 250 }
  
  validates_attachment_content_type :pdf, :content_type => %w(application/pdf)

  before_validation :set_permalink
  
private
  
  def set_permalink
    return if permalink.present? || title.blank?
    self.permalink = title.parameterize
  end

end
