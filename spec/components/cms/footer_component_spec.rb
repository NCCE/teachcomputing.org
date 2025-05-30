# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::FooterComponent, type: :component do
  before do
    render_inline(described_class.new(data: [
      Cms::Models::Data::TextField.new(value: Faker::Lorem.word),
      Cms::Models::Data::TextField.new(value: Faker::Lorem.word),
      Cms::Mocks::Images::Image.as_model,
      Cms::Mocks::Images::Image.as_model,
      Cms::Models::Meta::FooterLinkBlock.new(
        link_blocks: Array.new(4) do
          Array.new(5) { Cms::Mocks::DynamicComponents::ContentBlocks::LinkWithIcon.as_model }
        end
      )
    ]))
  end

  it "renders the component" do
    expect(page).to have_css(".cms-footer-component")
  end

  it "renders company and funder logo images" do
    expect(page).to have_css("img", count: 2)
  end

  it "renders the link blocks" do
    expect(page).to have_css(".cms-footer-component__link-block", count: 4)
  end
end
