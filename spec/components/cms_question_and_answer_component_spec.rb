# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsQuestionAndAnswerComponent, type: :component do
  before do
    stub_strapi_aside_section
  end

  context "standard layout" do
    before do
      render_inline(described_class.new(
        question: "Do you want to know more?",
        answer: Cms::Mocks::RichBlocks.as_model,
        aside_sections: [{slug: "test-aside"}],
        answer_icon_block: nil,
        aside_alignment: :top,
        show_background_triangle: false
      ))
    end

    it "should render question box" do
      expect(page).to have_css(".question-answer__question-content", text: "Do you want to know more?")
    end

    it "should render answer box with rich text block" do
      expect(page).to have_css(".question-answer__answer-content .cms-rich-text-block-component")
    end

    it "should add alignment class" do
      expect(page).to have_css(".tc-row-one-third.aside-alignment-top")
    end

    it "should render aside section" do
      expect(page).to have_css(".aside-component")
    end
  end

  context "with background and alignment bottom" do
    before do
      render_inline(described_class.new(
        question: "Do you want to know more?",
        answer: Cms::Mocks::RichBlocks.as_model,
        aside_sections: [{slug: "test-aside"}],
        answer_icon_block: nil,
        aside_alignment: :bottom,
        show_background_triangle: true
      ))
    end

    it "should add background image" do
      expect(page).to have_css(".question-answer__answer-content.answer-with-background")
    end

    it "should add alignment class" do
      expect(page).to have_css(".tc-row-one-third.aside-alignment-bottom")
    end
  end

  context "with icon block" do
    before do
      render_inline(described_class.new(
        question: "Do you want to know more?",
        answer: Cms::Mocks::RichBlocks.as_model,
        aside_sections: [{slug: "test-aside"}],
        answer_icon_block: Cms::Mocks::IconBlocks.as_model,
        aside_alignment: :top,
        show_background_triangle: false
      ))
    end

    it "should render icon block" do
      expect(page).to have_css(".icon-wrapper")
    end
  end

  context "without aside" do
    before do
      render_inline(described_class.new(
        question: "Do you want to know more?",
        answer: Cms::Mocks::RichBlocks.as_model,
        aside_sections: [],
        answer_icon_block: nil,
        aside_alignment: :top,
        show_background_triangle: false
      ))
    end

    it "should not render aside section" do
      expect(page).not_to have_css(".aside-component")
    end
  end
end
