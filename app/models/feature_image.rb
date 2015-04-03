class FeatureImage < ActiveRecord::Base

  belongs_to :provider
  mount_uploader :image, ImageUploader
  validates_presence_of :image
  validates_presence_of :provider

end
