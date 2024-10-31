require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Utils do
  before do
    stub_strapi_get_single_simple_page("simple-pages/test-page")
    stub_strapi_web_page_not_found("test-page")
    stub_strapi_create("web-pages")
  end

  it "should send correct data" do
    described_class.new.copy_simple_to_web_page("test-page")
    assert_requested(:post, "https://strapi.teachcomputing.org/api/web-pages", times: 1) do |request|
      sent_data = JSON.parse(request.body, symbolize_names: true)[:data]
      sent_data[:slug] == "test-page" && sent_data[:pageContent].count == 1
    end
  end
end
