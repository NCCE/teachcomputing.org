require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::Blocks::ProgrammeCardWrapper do
  before do
    card_section_data = Cms::Mocks::DynamicComponents::Blocks::ProgrammePictureCardSection.generate_data
    @card_wrapper = Cms::Providers::Strapi::Factories::BlocksFactory.to_programme_card_wrapper(card_section_data)
  end

  it "should render as CmsProgrammeWrapperComponent" do
    expect(@card_wrapper.render).to be_a(Cms::ProgrammeCardWrapperComponent)
  end
end
