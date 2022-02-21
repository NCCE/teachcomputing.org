require "test_helper"

class DownloadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @download = downloads(:one)
  end

  test "should get index" do
    get downloads_url
    assert_response :success
  end

  test "should get new" do
    get new_download_url
    assert_response :success
  end

  test "should create download" do
    assert_difference('Download.count') do
      post downloads_url, params: { download: { uri: @download.uri, user_id: @download.user_id } }
    end

    assert_redirected_to download_url(Download.last)
  end

  test "should show download" do
    get download_url(@download)
    assert_response :success
  end

  test "should get edit" do
    get edit_download_url(@download)
    assert_response :success
  end

  test "should update download" do
    patch download_url(@download), params: { download: { uri: @download.uri, user_id: @download.user_id } }
    assert_redirected_to download_url(@download)
  end

  test "should destroy download" do
    assert_difference('Download.count', -1) do
      delete download_url(@download)
    end

    assert_redirected_to downloads_url
  end
end
