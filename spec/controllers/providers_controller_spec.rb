require 'rails_helper'

RSpec.describe ProvidersController, type: :controller do
 include Devise::TestHelpers

  before :each do
    @provider = create(:provider)
  end

  # it "redirects to the home page upon save" do
  #   sign_in create(:provider).user
  #   post :create, provider: FactoryGirl.attributes_for(:provider)
  #   # expect(response).to
  # end
  it "renders the :index template" do
    sign_in @provider.user
    get :index
    expect(response).to render_template :index
  end

  describe "Providers' show page" do
    it "Display a specific provider information" do
      provider = create(:provider)
      sign_in provider.user
      get :show, id: provider
      expect(assigns(:provider)).to eq provider
    end

    describe "Renders show page template with or without authentication" do

      it "With authentication" do
        sign_in @provider.user
        get :show, id: @provider.slug
        expect(response).to render_template :show
      end

      it "Without authentication" do
        should be_able_to(:read, @provider)
        get :show, id: @provider.slug
        expect(response).to render_template :show
      end

    end

  end

  describe "Provider#new" do

    it "Renders new template" do
      sign_in @provider.user
      get :new
      expect(response).to_not render_template :new
    end

   it "Assigns a new Provider" do
      sign_in @provider.user
      get :new
      expect(assigns(:provider)).to be_a_new(Provider)
    end

  end

  describe "Provider#edit" do
    it "verify the requested provider" do
      sign_in @provider.user
      get :edit, id: @provider
      expect(assigns(:provider)).to eq @provider
    end

    it "Renders edit page" do
      sign_in @provider.user
      expect(response).to render_template :edit
    end

  end


end
