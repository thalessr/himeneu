require 'rails_helper'

describe Provider do
  it "is valid with a first_name and last_name" do
    provider = Provider.create(first_name: "Alta", last_name: "Floresta")
    expect(provider).to be_valid
  end
  it "is invalid without a first_name" do
    provider = Provider.create(first_name: nil, last_name: "Floresta")
    expect(provider.valid?).to be_falsey
    expect(provider.errors[:first_name].size).to eq(1)
  end

  it "returns a provider's full name as a string" do
   provider = Provider.create(first_name: "Alta", last_name: "Floresta")
   expect(provider.full_name).to eq "Alta Floresta"
  end

  it "returns just non deleted Providers" do
    Provider.create(first_name: "Alta", last_name: "Floresta", is_deleted: false)
    Provider.create(first_name: "Alta", last_name: "Floresta", is_deleted: true)
    expect(Provider.not_deleted.count).to eq(1)
  end

  it "returns just deleted Providers" do
    Provider.create(first_name: "Alta", last_name: "Floresta", is_deleted: false)
    Provider.create(first_name: "Alta", last_name: "Floresta", is_deleted: true)
    expect(Provider.deleted.count).to eq(1)
  end

  it "returns the correct video url format" do
    provider = Provider.create(first_name: "Alta", last_name: "Floresta", video_url: "https://www.youtube.com/watch?v=GoXv8ojxmGo")
    expect(provider.video_url).to eq("http://www.youtube.com/v/GoXv8ojxmGo")
  end

end