require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
	fixtures :users
	fixtures :providers
	fixtures :roles
	include Devise::TestHelpers


	def set_ability(user)
		@ability = Ability.new(user)
    @ability.extend(CanCan::Ability)
    @controller.stubs(:current_ability).returns(@ability)
	end

	test "Should get index" do
		@user = users(:bride_completed)
  	sign_in @user
		get :index
		assert_redirected_to(controller: "registrations", action: "new")
	end

	test "Not completed customer should get the new customers path" do
	  @user = users(:bride_not_completed)
	  @user.roles << roles(:noiva)
		set_ability(@user)
  	sign_in @user
  	@ability.can :create, Customer
		get :index
		assert_redirected_to(controller: "customers", action: "new")
	end

	test "Completed customer should get the providers path" do
	  @user = users(:bride_completed)
	  @user.roles << roles(:noiva)
		set_ability(@user)
  	sign_in @user
		get :index
		assert_redirected_to(controller: "providers", action: "index")
	end

	test "Not completed provider should get the new providers path" do
	  @user = users(:provider_not_completed)
	  @user.roles << roles(:fornecedor)
		set_ability(@user)
  	sign_in @user
		get :index
		assert_redirected_to(controller: "providers", action: "new")
	end

	test "Completed provider should get the root path" do
	  @user = users(:provider_completed)
	  @user.roles << roles(:fornecedor)
	  @user.provider = providers(:bride)
		set_ability(@user)
  	sign_in @user
		get :index
		assert_response :success
		assert_template :index
	end
end
