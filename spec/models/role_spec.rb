require 'rails_helper'

RSpec.describe Role, type: :model do

  context "db" do

    context "columns" do
      it { should have_db_column(:name).of_type(:string) }
      it { should have_db_column(:description).of_type(:text)}
    end

    context "relationships" do
      it { should have_and_belong_to_many(:users) }
    end

  end

end
