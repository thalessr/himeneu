class Recommendation < ActiveRecord::Base
	belongs_to :customer
	belongs_to :provider

  after_save :calculate_provider_score

  validates_presence_of :customer
  validates_presence_of :provider
  # validates_presence_of :rating


	def as_json(options = {})
		super(options.merge(include: {:customer => {:only => [:first_name, :image], :methods =>[:full_name]}}))
	end

  def calculate_provider_score
    provider = self.provider
    if provider
      score = 0.0
      provider = Provider.includes(:recommendations).find(provider.id)
      unless provider.recommendations.empty?
        score = provider.recommendations.average(:rating).to_f
      end
      provider.update_attribute(:score, score.to_f)
    end
  end

end
