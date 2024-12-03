# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsNumericCardComponent, type: :component do
  before do
    render_inline(described_class.new(
      title: nil,
      number: 1,
      text_content: Cms::Mocks::RichBlocks.as_model
    ))
  end

  it "should render the number" do
    expect(page).to have_css("h3.govuk-heading-l", text: "1")
  end

  it "should render the content" do
    expect(page).to have_css(".cms-rich-text-block-component")
  end
end
