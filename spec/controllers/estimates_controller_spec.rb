require 'rails_helper'

RSpec.describe EstimatesController, type: :controller do

  before :each do
    @customer = create(:customer)
    role = create(:role, id: 1)
    @customer.user.roles.delete_all
    @customer.user.roles << role
  end

  context "CRUD methods" do

    describe "GET #create" do
      it "returns http success" do
        sign_in :user, @customer.user
        params = { estimante: { description: "testing" } }
        post :create, params
        expect(response).to redirect_to(pending_subscriptions_path)
      end
    end


  end

end
