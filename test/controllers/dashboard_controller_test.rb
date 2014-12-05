require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
	fixtures :users
	include Devise::TestHelpers

	test "Should get index" do
		@user = users(:bride_completed)
  	    sign_in @user
		get :index
		assert_response :success
	end

	test "Bride Should get new customers paths" do
		@user = users(:bride_not_completed)
  	    sign_in @user
		get :index
		assert_redirected_to(controller: "customers", action: "new")
	end

	test "Should get new customers paths" do
		@user = users(:provider_not_completed)
  	    sign_in @user
		get :index
		assert_redirected_to(controller: "customers", action: "new")
	end
end
