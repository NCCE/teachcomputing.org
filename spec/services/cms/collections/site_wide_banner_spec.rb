require "rails_helper"

RSpec.describe Cms::Collections::SiteWideBanner do
  it "should have 5 minute cache expiry" do
    expect(described_class.cache_expiry).to eq(5.minutes)
  end

  it_should_behave_like "a strapi graphql collection single query", %w[textContent startTime endTime]
  it_should_behave_like "a strapi graphql collection all query", %w[textContent startTime endTime]
end
