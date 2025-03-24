# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::PrimaryGlossaryTableComponent, type: :component do
  let(:title) { Faker::Lorem.word }

  context "with records" do
    before do
      stub_strapi_primary_computing_glossary_table_collection

      render_inline(described_class.new(
        title: title
      ))
    end

    it "renders the title" do
      expect(page).to have_css("h2", text: title)
    end

    it "renders a table with headers" do
      expect(page).to have_css("table")
      expect(page).to have_css(".govuk-table__header", text: "Term")
      expect(page).to have_css(".govuk-table__header", text: "Key Stage")
      expect(page).to have_css(".govuk-table__header", text: "Definition")
    end

    it "renders the glossary records" do
      expect(page).to have_css(".govuk-table__row", count: 5)
      expect(page).to have_css(".cms-rich-text-block-component", count: 5)
    end
  end

  context "with no title" do
    before do
      stub_strapi_primary_computing_glossary_table_collection

      render_inline(described_class.new(
        title: nil
      ))
    end

    it "does not render a title" do
      expect(page).to_not have_css("h2")
    end
  end

  context "when strapi collection error" do
    before do
      stub_strapi_graphql_collection_error("primaryComputingGlossaryTables")

      render_inline(described_class.new(
        title: title
      ))
    end

    it "does not render" do
      expect(page).to_not have_css("table")
    end
  end

  context "when no records found" do
    before do
      stub_strapi_graphql_collection_query_missing("primaryComputingGlossaryTables")

      render_inline(described_class.new(
        title: title
      ))
    end

    it "does not render" do
      expect(page).to_not have_css("table")
    end
  end
end
