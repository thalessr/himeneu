CarrierWave.configure do |config|
  # config.root = Rails.root.join('tmp')
  # config.cache_dir = 'carrierwave'
  config.remove_previously_stored_files_after_update = true
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],       # required
    :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'], # required
    :region                 => ENV['REGION']                 # optional, defaults to 'us-east-1'
    # :endpoint               => 'himeneusp.s3-website-sa-east-1.amazonaws.com' # optional, defaults to nil
  }
  config.fog_directory  = ENV['S3_BUCKET']                          # required
  config.fog_public     = false                                        # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>"max-age=#{365.day.to_i}"} # optional, defaults to {}
end