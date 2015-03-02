class Address < ActiveRecord::Base
	has_one  :customer
	belongs_to :provider

	geocoded_by :full_address
    # after_validation :geocode_address, :if => :has_changes?
    after_validation :geocode

    private
    def full_address
    	if self.city and self.zipcode
	    	"#{city},#{zipcode}"
	    elsif self.city
	    	"#{city}"
	    else
	    	"#{zipcode}"
	    end
    end

    private
    def has_changes?
    	:city_changed? || :zipcode_changed?
    end

    private
    def geocode_address
  		GeocodeWorker.perform_async(self.id)
	  end

	class GeocodeWorker
	    include Sidekiq::Worker
	    sidekiq_options :queue => :default

	    def perform(id)
	      address = Address.find(id)
	      address.geocode
	      address.save!
	    end
	end

end
