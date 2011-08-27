require 'test_helper'

class OpenidConsumerControllerTest < ActionController::TestCase
  test "should get start" do
    get :start
    assert_response :success
  end

  test "should get complete" do
    get :complete
    assert_response :success
  end

end
