require "rails_helper"

RSpec.describe Cms::DynamicComponents::Blocks::HomepageHero do
  before do
    @comp = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::DynamicComponents::Blocks::HomepageHero.generate_raw_data)
  end

  it "should render as Cms::HomepageHeroComponent" do
    expect(@comp.render).to be_a(Cms::HomepageHeroComponent)
  end
end
