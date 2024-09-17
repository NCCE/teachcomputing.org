# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsFullWidthBannerComponent, type: :component do
  before do
    render_inline(described_class.new(
      text_content: [], # Cms::Mocks::RichBlocks.generate,
      image: nil, # Cms::Mocks::Image.as_model,
      image_side: :left,
      image_link: nil
    ))
  end

  it "renders the intro text" do
    expect(page).to have_css(".cms-rich-text-block-component")
  end
end
