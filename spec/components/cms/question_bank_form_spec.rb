# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::QuestionBankFormComponent, type: :component do
  before do
    render_inline(described_class.new(
      form_name: "Google Forms",
      links: Array.new(2) { Cms::Mocks::Link.as_model }
    ))
  end

  it "renders the form name" do
    expect(page).to have_text("Google Forms")
  end

  it "renders two links" do
    expect(page).to have_css("a", count: 2)
  end
end
