class Address < ActiveRecord::Base
	has_one :customer
end
