require "test_helper"

class HestiControllerTest < ActionDispatch::IntegrationTest
  test "should get create_account" do
    get hesti_create_account_url
    assert_response :success
  end

  test "should get log_in" do
    get hesti_log_in_url
    assert_response :success
  end

  test "should get log_out" do
    get hesti_log_out_url
    assert_response :success
  end
end
