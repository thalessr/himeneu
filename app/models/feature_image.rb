class FeatureImage < ActiveRecord::Base

  belongs_to :provider

  mount_uploader :image, ImageUploader
end
