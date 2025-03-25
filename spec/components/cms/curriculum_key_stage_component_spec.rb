# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::CurriculumKeyStagesComponent, type: :component do
  let(:key_stages_json_response) { File.new("spec/support/curriculum/responses/key_stages.json").read }

  before do
    client = CurriculumClient::Connection.connect(ENV.fetch("CURRICULUM_TEST_SCHEMA_PATH"))
    allow(CurriculumClient::Connection).to receive(:connect).and_return(client)
  end

  context "when curriculum is enabled" do
    before do
      stub_a_valid_request(key_stages_json_response)
      render_inline(described_class.new(
        title: "Choose resources by key stage",
        background_color: nil
      ))
    end
    it "renders the title" do
      expect(page).to have_css("h2.govuk-heading-m", text: "Choose resources by key stage")
    end
    it "renders the key stages" do
      expect(page).to have_css(".curriculum-card", count: 4)
    end

    it "sets key_stage 1 and 2 cards to orange" do
      expect(page).to have_css(".cms-color-theme__border--orange-left", text: "Key Stage 1")
      expect(page).to have_css(".cms-color-theme__border--orange-left", text: "Key Stage 2")
    end

    it "sets key_stage 3 and 4 cards to green" do
      expect(page).to have_css(".cms-color-theme__border--green-left", text: "Key Stage 3")
      expect(page).to have_css(".cms-color-theme__border--green-left", text: "Key Stage 4")
    end

  end
  context "when curriculum returns no keyStages" do
    before do
      stub_a_valid_request("{\"data\": { \"keyStages\": [] }}")
      render_inline(described_class.new(
        title: "Choose resources by key stage",
        background_color: nil
      ))
    end

    it "renders the title" do
      expect(page).not_to have_css("h2.govuk-heading-m", text: "Choose resources by key stage")
    end
  end

  context "when curriculum returns an error" do
    before do
      stub_an_invalid_request
      render_inline(described_class.new(
        title: "Choose resources by key stage",
        background_color: nil
      ))
    end

    it "renders the title" do
      expect(page).not_to have_css("h2.govuk-heading-m", text: "Choose resources by key stage")
    end
  end
end
