class Spree::CatalogEntry < ActiveRecord::Base

  has_and_belongs_to_many :products, :join_table => "spree_catalog_entries_products", :class_name => "Spree::Product", :order => "updated_at DESC"

  has_attached_file :image,
    :styles => {
      :mini   => '48x48>',
      :small  => '150x150>',
      :large  => '420x300>'
    }
  
  has_attached_file :pdf
  
  validates :title, :permalink, :presence => true
  validates :teaser, :length => { :maximum => 250 }
  
  validates_attachment_content_type :pdf, :content_type => %w(application/pdf)

  before_validation :set_permalink
  before_create :set_position
  
  def to_param
    self.permalink
  end
  
private
  
  def set_position
    self.position = (Spree::CatalogEntry.maximum(:position) || 0) + 1
  end
  
  def set_permalink
    return if permalink.present? || title.blank?
    self.permalink = title.parameterize
  end

end
