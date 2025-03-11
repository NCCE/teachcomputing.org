require "rails_helper"

RSpec.describe Cms::DynamicComponents::ContentBlocks::IBelongPictureCard do
  before do
    @i_belong_card = Cms::Providers::Strapi::Factories::BlocksFactory.to_i_belong_picture_card_section(
      Array.wrap(Cms::Mocks::DynamicComponents::ContentBlocks::IBelongPictureCard.generate_data)
    ).first
  end

  it "should render as CmsIBelongPictureCardComponent" do
    expect(@i_belong_card.render).to be_a(Cms::IBelongPictureCardComponent)
  end
end
