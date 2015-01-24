class Recommendation < ActiveRecord::Base
	belongs_to :customer
	belongs_to :provider

	validates :title, presence: true, length: { minimum: 5 }
  after_save :calculate_provider_score


	def as_json(options = {})
		super(options.merge(include: {:customer => {:only => [:first_name, :image], :methods =>[:full_name]}}))
	end

  def calculate_provider_score
    provider = self.provider
    if provider
      total_recommendations = provider.recommendations.count
      total_rating = provider.recommendations.sum(:rating)
      score = total_rating.to_f/total_recommendations.to_f
      provider.update_attribute(:score, score.to_f)
    end
  end

end
