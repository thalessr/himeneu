# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  # include CarrierWaveDirect::Uploader
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  process :set_content_type

  if Rails.env.production?
    include ::CarrierWave::Backgrounder::Delay
    storage :fog

    def store_dir
      "public/uploads/tmp"
    end

    def cache_dir
      "#{Rails.root}/tmp/uploads"
    end
  else
    storage :file

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_and_pad => [140, 140]
    process :lower_quality
  end

  version :regular do
    process :resize_and_pad => [300, 300]
    process :lower_quality
  end


  def lower_quality(quality=70)
    manipulate! do |img|
      img.auto_orient
      img.strip
      img.quality "#{quality}"
      img
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
