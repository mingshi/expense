require 'test_helper'

class ExpenseControllerTest < ActionController::TestCase
  test "should get myList" do
    get :myList
    assert_response :success
  end

end
