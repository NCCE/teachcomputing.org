# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsTextWithAsidesComponent, type: :component do
  before do
    stub_strapi_aside_section
    render_inline(described_class.new(blocks: [], asides: [{slug: "test-aside"}]))
  end

  it "renders govuk grid row" do
    expect(page).to have_css(".tc-gov-grid-wrapper")
  end

  it "has two thirds column" do
    expect(page).to have_css(".govuk-grid-column-two-thirds")
  end

  it "has one third column" do
    expect(page).to have_css(".govuk-grid-column-one-third")
  end

  it "should display aside section" do
    expect(page).to have_css(".aside-component")
  end
end
