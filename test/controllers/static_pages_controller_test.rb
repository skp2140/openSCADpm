require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
  end

  test "should get OpenScadpm" do
    get static_pages_OpenScadpm_url
    assert_response :success
  end

  test "should get Documentation" do
    get static_pages_Documentation_url
    assert_response :success
  end

end
