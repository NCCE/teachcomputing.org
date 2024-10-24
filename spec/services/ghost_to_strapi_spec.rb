require "rails_helper"

RSpec.describe GhostToStrapi do
  before do
    stub_posts_to_convert
    stub_pages_to_convert
    stub_strapi_blog_tags
    stub_strapi_media_upload
    stub_strapi_media_query
    stub_strapi_get_single_blog_post("blogs/reducing-workload", id: 3)
    stub_strapi_not_found("blogs/national-careers-week-2024")
    stub_strapi_not_found("simple-pages/privacy")
    stub_strapi_create("blogs")
    stub_strapi_update("blogs/3")
    stub_strapi_create("simple-pages")
  end

  it "should call the correct methods when converting posts" do
    problems = GhostToStrapi.new.convert_posts(2)
    expect(problems).to be_empty
    assert_requested(:put, "https://strapi.teachcomputing.org/api/blogs/3", times: 1) do |request|
      sent_data = JSON.parse(request.body, symbolize_names: true)[:data]
      sent_data[:slug] == "reducing-workload"
    end
    assert_requested(:post, "https://strapi.teachcomputing.org/api/blogs", times: 1) do |request|
      sent_data = JSON.parse(request.body, symbolize_names: true)[:data]
      sent_data[:slug] == "national-careers-week-2024"
    end
  end

  it "should call the correct methods when converting pages" do
    problems = GhostToStrapi.new.convert_pages(1)
    expect(problems).to be_empty
    assert_requested(:post, "https://strapi.teachcomputing.org/api/simple-pages", times: 1) do |request|
      sent_data = JSON.parse(request.body, symbolize_names: true)[:data]
      sent_data[:slug] == "privacy"
    end
  end

  context "process_html" do
    it "should convert unordered lists correctly" do
      response = GhostToStrapi.new.process_html("<ul><li>Item1</li><li>Item2</li></ul>")
      expect(response).to be_a(Array)
      first_item = response.first
      expect(first_item[:type]).to eq("list")
      expect(first_item[:format]).to eq("unordered")
      expect(first_item[:children].length).to eq(2)
    end

    it "should convert ordered lists correctly" do
      response = GhostToStrapi.new.process_html("<ol><li>Item1</li><li>Item2</li></ol>")
      expect(response).to be_a(Array)
      expect(response.first[:type]).to eq("list")
      expect(response.first[:format]).to eq("ordered")
      expect(response.first[:children].length).to eq(2)
    end

    it "should process blockquote correctly" do
      response = GhostToStrapi.new.process_html("<blockquote>We are going to need a bigger boat</blockquote>")
      expect(response).to be_a(Array)
      expect(response.first[:type]).to eq("quote")
    end

    it "should process figure correctly when kg-image-card" do
      response = GhostToStrapi.new.process_html("<figure class='kg-image-card'><img src='' alt='Alt text' /><figcaption>Some random text</figcaption></figure>")
      expect(response).to be_a(Array)
      expect(response.first[:type]).to eq("image")
    end

    it "should process figure correctly when kg-embed-card" do
      response = GhostToStrapi.new.process_html("<figure class='kg-embed-card'><img src='' alt='Alt text' /><figcaption>Some random text</figcaption></figure>")
      expect(response).to be_a(Array)
      expect(response.first[:type]).to eq("paragraph")
      expect(response.first[:children].first[:code]).to be true
    end

    it "should process code block correctly" do
      html = <<-HTML
        <p>Some text</p>
        <!--kg-card-begin: html-->
        <a href='#ftn_1'>To Footnote</a>
        <!--kg-card-end: html-->
        <p>Some more text</p>
      HTML
      response = GhostToStrapi.new.process_html(html)
      expect(response).to be_a(Array)
      expect(response.length).to eq(3)
      expect(response.second[:type]).to eq("paragraph")
      expect(response.second[:children].first[:code]).to be true
    end
  end
end
