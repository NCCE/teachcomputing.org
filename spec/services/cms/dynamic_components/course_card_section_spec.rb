require "rails_helper"

RSpec.describe Cms::DynamicComponents::CourseCard do
  let(:valid_course_card) { Cms::Mocks::DynamicComponents::CourseCard.generate_data(course_code: "CP228") }
  let(:invalid_course_card) { Cms::Mocks::DynamicComponents::CourseCard.generate_data(course_code: "NV228") }

  before do
    stub_course_templates
    stub_duration_units
  end

  context "with valid activity" do
    before do
      @card_section = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::CourseCardSection.generate_raw_data(cards: [valid_course_card]))
    end

    it "should render as Cms::CardWrapperComponent" do
      expect(@card_section.render).to be_a(Cms::CardWrapperComponent)
    end

    it "should render cards as Cms::DynamicsComponents::CourseCard" do
      expect(@card_section.cards_block.first.render).to be_a(Cms::CourseCardComponent)
    end

    it "should return true for valid code" do
      expect(@card_section.cards_block.first.render.render?).to be true
    end
  end

  context "with invalid activity" do
    before do
      @card_section = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::CourseCardSection.generate_raw_data(cards: [invalid_course_card]))
    end

    it "should return false for invalid code" do
      expect(@card_section.cards_block.first.render.render?).to be false
    end
  end
end
