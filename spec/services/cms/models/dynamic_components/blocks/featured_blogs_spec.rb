require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::Blocks::FeaturedBlogs do
  before do
    @blogs = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::DynamicComponents::Blocks::FeaturedBlogs.generate_raw_data)
    stub_featured_posts
  end

  it "should render as Cms::FeaturedBlogPostsComponent" do
    expect(@blogs.render).to be_a(Cms::FeaturedBlogPostsComponent)
  end
end
