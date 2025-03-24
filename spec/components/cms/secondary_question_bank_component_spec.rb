# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::SecondaryQuestionBankComponent, type: :component do
  let(:title) { Faker::Lorem.word }

  context "with records" do
    before do
      stub_strapi_secondary_question_bank_collection

      render_inline(described_class.new(
        title: title
      ))
    end

    it "renders the title" do
      expect(page).to have_css("h2", text: title)
    end

    it "renders the topics" do
      expect(page).to have_css(".secondary-question-bank-component__wrapper", count: 5)
    end
  end

  context "when strapi collection error" do
    before do
      stub_strapi_graphql_collection_error("secondaryQuestionBankTopics")

      render_inline(described_class.new(
        title: title
      ))
    end

    it "does not render" do
      expect(page).to_not have_css(".secondary-question-bank-component")
    end
  end

  context "when no records found" do
    before do
      stub_strapi_graphql_collection_query_missing("secondaryQuestionBankTopics")

      render_inline(described_class.new(
        title: title
      ))
    end

    it "does not render" do
      expect(page).to_not have_css(".secondary-question-bank-component")
    end
  end
end
