require 'rails_helper'

RSpec.describe Estimate, type: :model do
  context "db" do

    context "indexes" do
      it { should have_db_index(:customer) }
      it { should have_db_index(:provider_id) }
    end

    context "columns" do
      it { should have_db_column(:response) }
    end
  end
end
