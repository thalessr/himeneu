class Address < ActiveRecord::Base
	has_one :customer

	geocoded_by :full_address
    after_validation :geocode, :if => :city_changed?

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
end
