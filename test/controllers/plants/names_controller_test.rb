require "test_helper"

class Plants::NamesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
end
