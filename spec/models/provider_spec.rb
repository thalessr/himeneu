require 'rails_helper'

describe Provider do
  it "is valid with a first_name and last_name" do
    expect(build(:provider)).to be_valid
  end
  it "is invalid without a first_name" do
    provider = build(:provider, first_name: nil)
    expect(provider.valid?).to be_falsey
    expect(provider.errors[:first_name].size).to eq(1)
  end

  it "returns a provider's full name as a string" do
   expect(build(:provider, first_name: "Alta", last_name: "Floresta").full_name).to eq "Alta Floresta"
  end

  it "returns the correct video url format" do
    provider = create(:provider, video_url: "https://www.youtube.com/watch?v=GoXv8ojxmGo")
    expect(provider.video_url).to eq("http://www.youtube.com/v/GoXv8ojxmGo")
  end

  describe "it select deleted and non-deleted Providers" do
    before :each do
      @not_deleted = create(:provider, is_deleted: false)
      @deleted = create(:provider, is_deleted: true)
    end

    context "matching non-deleted" do

      it "returns just non deleted Providers" do
        filter = Provider.not_deleted
        expect(filter).to include(@not_deleted)
        expect(filter).to_not include(@deleted)
      end

    end

    it "returns just deleted Providers" do
      filter = Provider.deleted
      expect(filter).to include @deleted
      expect(filter).to_not include @not_deleted
    end

  end

  describe "searching filter" do
     before :each do
      @provider = create(:provider)
    end

    it "filter without any param" do
      search = Provider.search("")
      expect(search).to include @provider
    end

    it "filter by first_name or last_name" do
      search = Provider.search(@provider.first_name)
      expect(search).to include @provider
    end

    it "filter by first_name or last_name, and profession" do
      parameter = "#{@provider.first_name}, dev"
      search = Provider.search(parameter)
      expect(search).to include @provider
    end


    it "filter by first_name or last_name, profession, and city" do
      parameter = "#{@provider.first_name}, dev , #{@provider.addresses.first.city}"
      search = Provider.search(parameter)
      expect(search).to include @provider
    end

    it "filter by first_name or last_name, profession, and city - with invalid data" do
      parameter = "#{@provider.first_name}, dev , himeneulândia"
      search = Provider.search(parameter)
      expect(search).to_not include @provider
    end

  end

end