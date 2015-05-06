require 'rails_helper'

RSpec.describe User, type: :model do

  context "db" do

    context "indexes" do
      it { should have_db_index(:email) }
      it { should have_db_index(:confirmation_token) }
    end

    context "columns" do
      it { should have_db_column(:email).of_type(:string) }
      it { should have_db_column(:encrypted_password).of_type(:string)}
      it { should have_db_column(:reset_password_token).of_type(:string)}
      it { should have_db_column(:sign_in_count).of_type(:integer)}
      it { should have_db_column(:is_completed).of_type(:boolean)}
      it { should have_db_column(:unconfirmed_email).of_type(:string)}
      it { should have_db_column(:confirmation_token).of_type(:string)}
    end

    context "relationships" do
      it { should have_and_belong_to_many(:roles) }
      it { should have_one(:customer) }
      it { should have_one(:provider) }
    end

  end

end
