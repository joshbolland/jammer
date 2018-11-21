require 'test_helper'

class SlotsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get slots_new_url
    assert_response :success
  end

  test "should get create" do
    get slots_create_url
    assert_response :success
  end

end
