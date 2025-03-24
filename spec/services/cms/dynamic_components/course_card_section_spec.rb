require "rails_helper"

RSpec.describe Cms::DynamicComponents::CourseCard do
  let!(:activity) { Activity.find_by(stem_activity_code: "CP228") || create(:activity, stem_activity_code: "CP228") }
  let!(:new_activity) { Activity.find_by(stem_activity_code: "CP229") || create(:activity, stem_activity_code: "CP229") }
  let!(:replaced_activity) { create(:activity, stem_activity_code: "RP228", replaced_by: new_activity) }
  let(:valid_course_card) { Cms::Mocks::DynamicComponents::CourseCard.generate_data(course_code: "CP228") }
  let(:replaced_course_card) { Cms::Mocks::DynamicComponents::CourseCard.generate_data(course_code: "RP228") }
  let(:invalid_course_card) { Cms::Mocks::DynamicComponents::CourseCard.generate_data(course_code: "NV228") }

  before do
    stub_course_templates
    stub_duration_units
    allow(Sentry).to receive(:capture_message)
  end

  context "with valid activity" do
    let(:card_section) { Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::CourseCardSection.generate_raw_data(cards: [valid_course_card])) }
    let(:first_block) { card_section.cards_block.first }

    it "should render as Cms::CardWrapperComponent" do
      expect(card_section.render).to be_a(Cms::CardWrapperComponent)
    end

    it "should render cards as Cms::DynamicsComponents::CourseCard" do
      expect(first_block.render).to be_a(Cms::CourseCardComponent)
    end

    it "should return true for valid code" do
      expect(first_block.render.render?).to be true
    end

    it "should have correct course instance" do
      expect(first_block.course.activity_code).to eq("CP228")
    end

    it "should not send sentry notification" do
      expect(Sentry).not_to have_received(:capture_message)
    end
  end

  context "with invalid activity" do
    let(:card_section) { Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::CourseCardSection.generate_raw_data(cards: [invalid_course_card])) }
    let(:first_block) { card_section.cards_block.first }

    it "should return false for invalid code" do
      expect(first_block.render.render?).to be false
    end

    it "should have no course instance" do
      expect(first_block.course).to be_nil
    end

    it "should not send sentry notification" do
      expect(Sentry).not_to have_received(:capture_message)
    end
  end

  context "with replaced activity" do
    let!(:card_section) { Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::CourseCardSection.generate_raw_data(cards: [replaced_course_card])) }
    let(:first_block) { card_section.cards_block.first }


    it "should render as Cms::CardWrapperComponent" do
      expect(card_section.render).to be_a(Cms::CardWrapperComponent)
    end

    it "should render cards as Cms::DynamicsComponents::CourseCard" do
      expect(first_block.render).to be_a(Cms::CourseCardComponent)
    end

    it "should return true for valid code" do
      expect(first_block.render.render?).to be true
    end

    it "should have correct course instance" do
      expect(first_block.course.activity_code).to eq("CP229")
    end

    it "should send sentry notification" do
      expect(Sentry).to have_received(:capture_message).once.with("Course card has been found with a now replaced course (RP228 -> CP229) - get comms to update Strapi to new course instance")
    end
  end
end
