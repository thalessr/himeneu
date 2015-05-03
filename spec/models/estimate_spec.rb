require 'rails_helper'

RSpec.describe Estimate, type: :model do
  context "db" do

    context "indexes" do
      it { should have_db_index(:customer_id) }
      it { should have_db_index(:provider_id) }
    end

    context "columns" do
      it { should have_db_column(:response).of_type(:text) }
      it { should have_db_column(:description).of_type(:text)}
      it { should have_db_column(:customer_id).of_type(:integer)}
      it { should have_db_column(:provider_id).of_type(:integer)}
    end

    context "relationships" do
      it { should belong_to(:provider) }
      it { should belong_to(:customer) }
    end

  end

end
