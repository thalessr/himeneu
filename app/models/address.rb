class Address < ActiveRecord::Base
	has_one :customer

	geocoded_by :full_address
    after_validation :geocode, :if => :city_changed?

    private
    def full_address
    	"#{city},#{zipcode}"
    end
end
