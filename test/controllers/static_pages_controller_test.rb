require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get anuncie" do
    get :anuncie
    assert_response :success
  end

  test "should get sobre" do
    get :sobre
    assert_response :success
  end

  test "should get contato" do
    get :contato
    assert_response :success
  end

end
