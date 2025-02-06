require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Utils do
  before do
    allow(Rails.application.config).to receive(:strapi_connection_type).and_return("rest")
    stub_strapi_web_page_not_found("test-page")
    stub_strapi_create("web-pages")
  end

  it "should send correct data" do
    described_class.new.upload_to_strapi({
      slug: "test-page",
      pageContent: [
        Cms::Mocks::TextWithAsides.generate_raw_data
      ]
    }, "web-pages")
    assert_requested(:post, "https://strapi.teachcomputing.org/api/web-pages", times: 1) do |request|
      sent_data = JSON.parse(request.body, symbolize_names: true)[:data]
      sent_data[:slug] == "test-page" && sent_data[:pageContent].count == 1
    end
  end
end
