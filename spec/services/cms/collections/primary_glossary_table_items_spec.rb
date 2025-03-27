require "rails_helper"

RSpec.describe Cms::Collections::PrimaryGlossaryTableItems do
  it "should have 4 hour cache expiry" do
    expect(described_class.cache_expiry).to eq(4.hours)
  end

  it_should_behave_like "a strapi graphql collection single query", %w[term keyStage definition]
  it_should_behave_like "a strapi graphql collection all query", %w[term keyStage definition]
end
