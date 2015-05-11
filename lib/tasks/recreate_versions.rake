namespace :recreate_versions do
  desc "Recreate the images versions for all of providers"
  task providers: :environment do
    Provider.where.not(image: nil).find_each do |p|
      begin
        p.process_image_upload = true
        p.image.cache_stored_file!
        p.image.retrieve_from_cache!(p.image.cache_name)
        p.image.recreate_versions!
        p.save!
      rescue => e
        puts  "ERROR: YourModel: #{p.id} -> #{e.to_s}"
      end
    end
  end

  desc "Recreate the images versions for all of customers"
  task customers: :environment do
    Customer.where.not(image: nil).find_each do |p|
      begin
        p.process_image_upload = true
        p.image.cache_stored_file!
        p.image.retrieve_from_cache!(p.image.cache_name)
        p.image.recreate_versions!
        p.save!
      rescue => e
        puts  "ERROR: YourModel: #{p.id} -> #{e.to_s}"
      end
    end
  end

  desc "Recreate the images versions of providers'feature images"
  task feature_images: :environment do
    FeatureImage.where.not(image: nil).find_each do |p|
      begin
        p.process_image_upload = true
        p.image.cache_stored_file!
        p.image.retrieve_from_cache!(p.image.cache_name)
        p.image.recreate_versions!
        p.save!
      rescue => e
        puts  "ERROR: YourModel: #{p.id} -> #{e.to_s}"
      end
    end
  end

end
