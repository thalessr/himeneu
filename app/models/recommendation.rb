class Recommendation < ActiveRecord::Base
	belongs_to :customer
	belongs_to :provider

	validates :title, presence: true, length: { minimum: 5 }


	def as_json(options = {})
		super(options.merge(include: {:customer => {:only => [:first_name, :image], :methods =>[:full_name]}}))
	end

end
