require 'test_helper'

class ProvidersControllerTest < ActionController::TestCase
  fixtures :users
  include Devise::TestHelpers

  def setup
    @provider = users(:provider_not_completed)
  end

  def teardown
    @provider = nil
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get create" do
    sign_in @provider
    post :create
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get destroy" do
    sign_in @provider
    delete :destroy, id: @provider
    assert_response :success
  end

  test "should get show" do
    sign_in @provider
    get :show, id: @provider
    assert_response :success
  end

end
