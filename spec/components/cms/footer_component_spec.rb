# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::FooterComponent, type: :component do
  let(:data) { Cms::Singles::Footer.get }

  before do
    stub_strapi_footer
    render_inline(described_class.new(data:))
  end

  it "renders the component" do
    expect(page).to have_css(".cms-footer-component")
  end

  it "renders company and funder logo images" do
    expect(page).to have_css("img", count: 2)
  end

  it "has the company logo link" do
    expect(page).to have_link(href: data.get_model(:company_logo_link).value)
  end

  it "has the funder logo link" do
    expect(page).to have_link(href: data.get_model(:funder_logo_link).value)
  end

  it "renders the link blocks" do
    expect(page).to have_css(".cms-footer-component__link-block", count: 4)
  end
end
