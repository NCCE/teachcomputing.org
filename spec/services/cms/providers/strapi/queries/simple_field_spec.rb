require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::SimpleField do
  it_should_behave_like "a strapi graphql embed", {key: "name"}
end
