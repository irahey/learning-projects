require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)    #Logging in a test user.
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name:  "",
                                    email: "foo@invalid",
                                    password:              "foo",
                                    password_confirmation: "bar" }
    assert_template 'users/edit'
  end
  
    test "successful edit with friendly forwarding" do      #A test for friendly forwarding. Redirects are always friendlier
    get edit_user_path(@user)     #reversing the order of logging in and visiting the edit page in --> GET first, then log_in -->88will be redirected to /users/1 instead of /users/1/edit. 
    log_in_as(@user)              
    assert_redirected_to edit_user_path(@user)      
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), user: { name:  name,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end