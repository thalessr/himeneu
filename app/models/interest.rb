class Interest < ActiveRecord::Base
	belongs_to :provider
  	belongs_to :customer
end
