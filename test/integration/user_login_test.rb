require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:andy)
  end

  test "login with invalid information" do
    get new_user_session_path
    assert_template 'devise/sessions/new'
    post user_session_path, 'user[email]' => @user.email,
                            'user[password]' => 'wrong-password'
    assert_template 'devise/sessions/new'
    assert_not is_logged_in?
  end

  test "login with valid information, followed by logout" do
    get new_user_session_path
    assert_template 'devise/sessions/new'
    post user_session_path, 'user[email]' => @user.email,
                            'user[password]' => 'password'
    assert is_logged_in?
    delete destroy_user_session_path
    assert_not is_logged_in?
  end
end
