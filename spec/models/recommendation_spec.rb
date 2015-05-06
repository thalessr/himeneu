require 'rails_helper'

RSpec.describe Recommendation, type: :model do

  context "db" do

    context "indexes" do
      it { should have_db_index(:customer_id) }
      it { should have_db_index(:provider_id) }
    end

    context "columns" do
      it { should have_db_column(:comment).of_type(:text) }
      it { should have_db_column(:title).of_type(:string)}
      it { should have_db_column(:rating).of_type(:integer)}
      it { should have_db_column(:customer_id).of_type(:integer)}
      it { should have_db_column(:provider_id).of_type(:integer)}
    end

    context "relationships" do
      it { should belong_to(:provider) }
      it { should belong_to(:customer) }
    end

    context "validations" do
      it { should validate_presence_of(:rating)}
      it { should validate_presence_of(:customer)}
      it { should validate_presence_of(:provider)}
    end

  end

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
