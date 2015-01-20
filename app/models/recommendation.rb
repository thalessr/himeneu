class Recommendation < ActiveRecord::Base
	belongs_to :customer
	belongs_to :provider

	validates :title, presence: true, length: { minimum: 5 }
end
