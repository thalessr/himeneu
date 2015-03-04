require 'rails_helper'

RSpec.describe Customer, type: :model do
  it "Should be invalid without first_name"
  it "Should be invalid without last_name"
  it "Should be invalid without age"
  it "Should be invalid without wedding_date"
  it "Should be valid with first_name, last_name, age and wedding_date"
  describe "Searchin filtered by" do
    it "first_name"
    it "last_name"
    it "city"
  end
end
