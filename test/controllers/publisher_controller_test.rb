require 'test_helper'

class PublisherControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
