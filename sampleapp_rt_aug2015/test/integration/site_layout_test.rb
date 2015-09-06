require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
#In this case, we use a syntax that allows us to test for the presence of a particular link–URL combination by specifying the tag name a and attribute href
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path #, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    #Using the full_title helper in a test.
    #get signup_path
    #assert_select "title", full_title("Sign up")
  end
end