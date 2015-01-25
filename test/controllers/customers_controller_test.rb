require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  fixtures :users
  fixtures :customers
  include Devise::TestHelpers

 def setup
    @user = users(:bride_not_completed)
    @customer = customers(:valid_customer)
    @ability = Ability.new(@user)
    @ability.extend(CanCan::Ability)
    @controller.stubs(:current_ability).returns(@ability)
    sign_in @user
  end

  def teardown
    @user = nil
    @customer = nil
    @ability = nil
  end

  test "Shoud reach customer#new" do
    @ability.can(:read, Customer)
    get :new
    assert_response :success
  end

  test "Should create a new customer" do
    @ability.can(:create, Customer)
    assert_difference('Customer.count') do
      post :create, customer: @customer.attributes
    end
    assert_redirected_to assigns(:customer)
  end

  test "Should read the custmer#show" do
    @ability.can(:read, Customer)
    get :show, id: @customer
    assert_response :success
    assert_template :show
  end

  test "Should edit a customer" do
    @ability.can(:edit, Customer)
    get :edit, id: @customer
    assert_response :success
  end

  test "Should update a customer" do
    @ability.can(:update, Customer)
    put :update, id: @customer , customer: @customer.attributes
    assert_redirected_to assigns(:customer)
  end

  test "Should get destroy" do
    @ability.can :destroy, Customer
    delete :destroy, id: @customer
    assert_redirected_to(controller: "customers", action: "new")
  end

end
