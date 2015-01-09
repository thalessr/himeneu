 class Provider < ActiveRecord::Base
	belongs_to :user
	has_many :addresses
end
