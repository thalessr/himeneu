require 'test_helper'

class RecommendationsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  fixtures :users
  fixtures :providers
  fixtures :recommendations
  include Devise::TestHelpers

  def set_ability(user)
    @ability = Ability.new(user)
    @ability.extend(CanCan::Ability)
    @controller.stubs(:current_ability).returns(@ability)
  end

  test "Should create a new recommendation" do
    @user = users(:bride_completed)
    @user.roles << roles(:noiva)
    @user.customer = customers(:valid_customer)
    sign_in @user
    set_ability(@user)
    @recommendation = recommendations(:recommendation)
    @ability.can :create, Recommendation
    assert_difference('Recommendation.count') do
      post :create, :provider_id => :provider, recommendation: @recommendation.attributes
    end
    # assert_redirected_to assigns(:provider)

  end
end
