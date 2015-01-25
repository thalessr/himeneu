require 'test_helper'


class ProvidersControllerTest < ActionController::TestCase
  fixtures :users
  fixtures :providers
  include Devise::TestHelpers

  def setup
    @user = users(:provider_not_completed)
    @provider = providers(:bride)
    @ability = Ability.new(@user)
    @ability.extend(CanCan::Ability)
    @controller.stubs(:current_ability).returns(@ability)
    sign_in @user
  end

  def teardown
    @user = nil
    @provider = nil
  end

  test "should get index" do
    @ability.can :read, Provider
    get :index
    assert_template :index
  end

  test "should have a permission to create a new provider" do
    @ability.can :create, Provider
    get :new
    assert_response :success
  end

  test "should create a provider" do
    @ability.can :create, Provider
    assert_difference('Provider.count') do
      post :create, provider: @provider.attributes
    end
    assert_redirected_to assigns(:provider)
  end

  test "should get edit" do
    @ability.can :edit, Provider
    get :edit, id: @provider
  end

  test "should update a provider" do
    @ability.can :update, Provider
    put :update, id: @provider ,provider: @provider.attributes
    assert_redirected_to assigns(:provider)
  end

  test "should get destroy" do
    @ability.can :destroy, Provider
    delete :destroy, id: @provider
    assert_redirected_to(controller: "providers", action: "new")
  end

  test "should get show" do
    @ability.can :read, Provider
    get :show, id: @provider
    assert_response :success
  end

end
