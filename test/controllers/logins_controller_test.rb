require "test_helper"

class LoginsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_logins_url
    assert_response :success
  end

  test "should get create" do
    post logins_url
    # No credentials in fixtures — failed login renders 'new' with 422
    assert_response :unprocessable_entity
  end
end
