require 'test_helper'

class ForgotpasswordControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
