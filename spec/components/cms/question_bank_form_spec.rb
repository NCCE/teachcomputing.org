# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::QuestionBankFormComponent, type: :component do
  let(:links) { Array.new(2) { Cms::Mocks::DynamicComponents::ContentBlocks::Link.as_model } }

  before do
    render_inline(described_class.new(
      form_name: "Google Forms",
      links:
    ))
  end

  it "renders the form name" do
    expect(page).to have_text("Google Forms")
  end

  it "renders two links" do
    expect(page).to have_link(links.first.link_text, href: links.first.url)
    expect(page).to have_link(links.second.link_text, href: links.second.url)
  end
end
