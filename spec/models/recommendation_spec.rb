require 'rails_helper'

RSpec.describe Recommendation, type: :model do

  it "Should be valid" do
    expect(build(:recommendation)).to be_valid
  end

  it "Should be invalid without a customer" do
    recommendation = build(:recommendation, customer_id: nil)
    expect(recommendation.valid?).to be_falsey
    expect(recommendation.errors[:customer].size).to eq(1)
  end
  it "Should be invalid without a provider" do
    recommendation = build(:recommendation, provider_id: nil)
    expect(recommendation.valid?).to be_falsey
    expect(recommendation.errors[:provider].size).to eq(1)
  end

  it "Should be invalid without a rating" do
    recommendation = build(:recommendation, rating: nil)
    expect(recommendation.valid?).to be_falsey
    expect(recommendation.errors[:rating].size).to eq(1)
  end

end
