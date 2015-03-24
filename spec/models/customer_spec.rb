require 'rails_helper'

RSpec.describe Customer, type: :model do

  it "Should be invalid without first_name" do
    customer = build(:customer, first_name: nil)
    expect(customer.valid?).to be_falsey
    expect(customer.errors[:first_name].size).to eq(1)
  end
  it "Should be invalid without last_name" do
    customer = build(:customer, last_name: nil)
    expect(customer.valid?).to be_falsey
    expect(customer.errors[:last_name].size).to eq(1)
  end
  it "Should be invalid without age" do
    customer = build(:customer, age: nil)
    expect(customer.valid?).to be_falsey
    expect(customer.errors[:age].size).to eq(1)
  end
  it "Should be invalid without wedding_date" do
    customer = build(:customer, wedding_date: nil)
    expect(customer.valid?).to be_falsey
    expect(customer.errors[:wedding_date].size).to eq(1)
  end
  it "Should be valid with first_name, last_name, age and wedding_date" do
    expect(build(:customer)).to be_valid
  end
  describe "Searching filtered by" do
    before :each do
      @customer = create(:customer)
    end

    it "without any param" do
      search = Customer.search("")
      expect(search).to include @customer
    end

    it "first_name" do
      search = Customer.search(@customer.first_name)
      expect(search).to include @customer
    end

    it "last_name" do
      search = Customer.search(@customer.last_name)
      expect(search).to include @customer
    end

    it "city" do
      search = Customer.search(@customer.city)
      expect(search).to include @customer
    end

  end

  describe "it select deleted and non-deleted Customers" do
    before :each do
      @not_deleted = create(:customer, is_deleted: false)
      @deleted = create(:customer, is_deleted: true)
    end


    it "returns just non deleted Customers" do
      filter = Customer.not_deleted
      expect(filter).to include(@not_deleted)
      expect(filter).to_not include(@deleted)
    end


    it "returns just deleted Customers" do
      filter = Customer.deleted
      expect(filter).to include @deleted
      expect(filter).to_not include @not_deleted
    end

  end

  describe "it select deleted and recover Customers" do
    before :each do
       @customer = build(:customer)
    end
    it "should delete" do
      @customer.delete
      expect(@customer.is_deleted?).to be true
    end

    it "should recover" do
      @customer.recover
      expect(@customer.is_deleted?).to be_falsey
    end
  end

end
