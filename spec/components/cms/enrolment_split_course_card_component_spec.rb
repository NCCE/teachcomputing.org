# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::EnrolmentSplitCourseCardComponent, type: :component do
  let!(:programme) { create(:primary_certificate) }
  let(:unenrolled_user) { create(:user) }
  let(:enrolled_user) {
    user = create(:user)
    create(:user_programme_enrolment, user:, programme:)
    user
  }
  let(:enrol_aside_slug) { [{slug: "enrol-split-card-aside"}] }

  before do
    stub_strapi_aside_section(enrol_aside_slug.first[:slug], aside_data: {title: "Ready to enrol?"})
  end

  context "User not logged in" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(nil)
      render_inline(described_class.new(
        card_content: Cms::Mocks::Text::RichBlocks.as_model,
        aside_content: Cms::Mocks::Text::RichBlocks.as_model,
        enrol_aside: enrol_aside_slug,
        programme: programme,
        background_color: "purple",
        color_theme: "standard",
        section_title: Faker::Lorem.sentence,
        aside_title: Faker::Lorem.sentence,
        aside_icon: Cms::Mocks::Images::Image.as_model
      ))
    end

    it "should render split card wrapper" do
      expect(page).to have_css(".cms-split-horizontal-card-wrapper")
    end

    it "should render main card only" do
      expect(page).to have_css(".split-horizontal-card", count: 1)
    end

    it "should render correct aside" do
      expect(page).to have_css(".aside-component__heading", text: "Ready to enrol?")
    end
  end

  context "User logged in but not enrolled" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(unenrolled_user)
      render_inline(described_class.new(
        card_content: Cms::Mocks::Text::RichBlocks.as_model,
        aside_content: Cms::Mocks::Text::RichBlocks.as_model,
        enrol_aside: enrol_aside_slug,
        programme: programme,
        background_color: "purple",
        color_theme: "standard",
        section_title: nil,
        aside_title: Faker::Lorem.sentence,
        aside_icon: Cms::Mocks::Images::Image.as_model
      ))
    end

    it "if section_header is nil should not render" do
      expect(page).not_to have_css(".govuk-heading-m")
    end

    it "should render split card wrapper" do
      expect(page).to have_css(".cms-split-horizontal-card-wrapper")
    end

    it "should render main card only" do
      expect(page).to have_css(".split-horizontal-card", count: 1)
    end

    it "should render correct aside" do
      expect(page).to have_css(".aside-component__heading", text: "Ready to enrol?")
    end
  end

  context "User logged in and enrolled" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(enrolled_user)
      render_inline(described_class.new(
        card_content: Cms::Mocks::Text::RichBlocks.as_model,
        aside_content: Cms::Mocks::Text::RichBlocks.as_model,
        enrol_aside: enrol_aside_slug,
        programme: programme,
        background_color: "purple",
        color_theme: "standard",
        section_title: nil,
        aside_title: Faker::Lorem.sentence,
        aside_icon: Cms::Mocks::Images::Image.as_model
      ))
    end

    it "if section_header is nil should not render" do
      expect(page).not_to have_css(".govuk-heading-m")
    end

    it "should render split card wrapper" do
      expect(page).to have_css(".cms-split-horizontal-card-wrapper")
    end

    it "should render main card and side card" do
      expect(page).to have_css(".split-horizontal-card", count: 2)
    end

    it "should not render enrolled aside" do
      expect(page).not_to have_css(".aside-component__heading", text: "Ready to enrol?")
    end
  end
end
