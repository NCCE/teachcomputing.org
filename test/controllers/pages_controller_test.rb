require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get page" do
    get pages_page_url
    assert_response :success
  end

end
