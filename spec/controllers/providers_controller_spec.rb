require 'rails_helper'

describe ProvidersController, type: :controller do
 include Devise::TestHelpers

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @provider = create(:provider)
    role = create(:role, id: 2, name: "fornecedor")
    @provider.user.roles.delete_all
    @provider.user.roles << role
  end

  it "renders the :index template" do
    sign_in @provider.user
    get :index
    expect(response).to render_template :index
  end

  describe "Providers' show page" do
    it "Display a specific provider information" do
      sign_in @provider.user
      get :show, id: @provider
      expect(assigns(:provider)).to eq @provider
    end

    describe "Renders show page template with or without authentication" do

      it "With authentication" do
        sign_in @provider.user
        get :show, id: @provider.slug
        expect(response).to render_template :show
      end

      it "Without authentication" do
        get :show, id: @provider.slug
        expect(response).to render_template :show
      end

    end

  end

  describe "Provider#new" do

    it "Renders new template" do
      sign_in @provider.user
      get :new
      expect(response).to render_template :new
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
      get :edit, id: @provider.slug
      expect(response).to render_template :edit
    end

  end

  describe "Provider#create" do

    it "Create a new provider" do
      sign_in @provider.user
      @provider.user = nil
      expect(response).to redirect_to provider_path(assigns[:provider])
    end

  end

  describe "Provider#update" do
    it "Update a provider" do
      sign_in @provider.user
      patch :update, id: @provider.slug ,provider: attributes_for(:provider)
      expect(assigns(:provider)).to eq @provider
    end

    it "Changes provider's attributes" do
      sign_in @provider.user
      patch :update, id: @provider.slug ,provider: attributes_for(:provider, first_name: "Nunes", last_name:"Costa")
      @provider.reload
      expect(@provider.first_name).to eq ("Nunes")
      expect(@provider.last_name).to eq ("Costa")
    end

    it "Should not change provider's attributes" do
      sign_in @provider.user
      patch :update, id: @provider.slug ,provider: attributes_for(:provider, first_name: nil, last_name:"Costa")
      @provider.reload
      expect(@provider.last_name).to_not eq ("Costa")
    end

     it "Should re-render edit page" do
      sign_in @provider.user
      patch :update, id: @provider.slug ,provider: attributes_for(:provider, first_name: nil, last_name:"Costa")
      expect(response).to render_template :edit
    end

  end

  describe "Provider#destroy" do

    it "Delete a provider" do
      sign_in @provider.user
      delete :destroy, id: @provider
      @provider.reload
      expect(@provider.is_deleted).to be true
    end

    it "Recover a provider" do
      sign_in @provider.user
      get :recover, id: @provider
      @provider.reload
      expect(@provider.is_deleted).to be false
    end

  end

  describe "Provider#search" do

    it "Should find a provider" do
      sign_in @provider.user
      get :search, q: @provider.first_name, page: 1, format: :json
      expect(response.body).to have_content @provider.to_json
    end

  end


end
