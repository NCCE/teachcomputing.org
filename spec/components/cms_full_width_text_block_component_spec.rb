# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsFullWidthTextBlockComponent, type: :component do
  before do
    render_inline(described_class.new(blocks: Cms::Mocks::RichBlocks.as_model))
  end

  it "renders govuk grid row" do
    expect(page).to have_css(".tc-gov-grid-wrapper")
  end

  it "has two full width column" do
    expect(page).to have_css(".govuk-grid-column-full-width")
  end
end
