require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  #Adding account activation to the user signup test.
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'users/new'
    #assert_select 'div#<CSS id for error explanation>'      # A template for tests of the error messages.
    #assert_select 'div.<CSS class for field with error>'    # A template for tests of the error messages.
  end
  test "valid signup information with account activation" do
    #Adding account activation to the user signup test.
    get signup_path
    assert_difference 'User.count', 1 do
      #post_via_redirect users_path, user: { name:  "Example User",
      post users_path, user: { name:  "Example User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
    end

    #assert_not flash.FILL_IN     # A template for a test of the flash.

      # below are commented out bcos acct activation is added
    #assert_template 'users/show'
    #assert is_logged_in?    # A test of login after signup.

    assert_equal 1, ActionMailer::Base.deliveries.size    #This code verifies that exactly 1 message was delivered.
    user = assigns(:user)
    assert_not user.activated?
    # Try to log in before activation.
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end