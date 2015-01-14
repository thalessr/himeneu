require 'test_helper'
require "mocha/mini_test"

class ProvidersControllerTest <  MiniTest::Unit::TestCase
  fixtures :users
  fixtures :providers
  include Devise::TestHelpers

  def setup
    @user = users(:bride_not_completed)
    @provider = providers(:bride)
    sign_in @user
  end

  def teardown
    @user = nil
    @provider = nil
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create a provider" do
    assert_difference('Provider.count') do
      post :create,provider: @provider.attributes
    end
    assert_redirected_to assigns(:provider)
  end

  test "should get edit" do
    get :edit, id: @provider
    assert_response :success
  end

  test "should update a provider" do
    put :update, id: @provider ,provider: @provider.attributes
    assert_redirected_to assigns(:provider)
  end

  test "should get destroy" do
    delete :destroy, id: @provider
    assert_redirected_to(controller: "providers", action: "new")
  end

  test "should get show" do
    get :show, id: @provider
    assert_response :success
  end

end
