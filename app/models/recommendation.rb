class Recommendation < ActiveRecord::Base
	belongs_to :customer
	belongs_to :provider

	validates :title, presence: true, length: { minimum: 1 }
  validates :comment, presence: true, length: { minimum: 1 }
  after_save :calculate_provider_score


	def as_json(options = {})
		super(options.merge(include: {:customer => {:only => [:first_name, :image], :methods =>[:full_name]}}))
	end

  def calculate_provider_score
    provider = self.provider
    if provider
      score = 0.0
      unless provider.recommendations.empty?
        score = provider.recommendations.average(:rating).to_f
      end
      # total_rating = provider.recommendations.sum(:rating)
      # score = total_rating.to_f/total_recommendations.to_f
      provider.update_attribute(:score, score.to_f)
    end
  end

end
