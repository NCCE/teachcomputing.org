require "rails_helper"

RSpec.describe Cms::DynamicComponents::Blocks::FeaturedBlogs do
  before do
    @blogs = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::DynamicComponents::Blocks::FeaturedBlogs.generate_raw_data)
    stub_featured_posts
  end

  it "should render as FeaturedBlogPostsComponent" do
    expect(@blogs.render).to be_a(FeaturedBlogPostsComponent)
  end
end
