# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::CommunityActivityListComponent, type: :component do
  let(:programme) { create(:primary_certificate) }
  let(:programme_activity_grouping) { create(:programme_activity_grouping, community: true, programme:) }
  let!(:activity1) { create(:activity, :community) }
  let!(:activity2) { create(:activity, :community) }
  let!(:activity_group_join1) { create(:programme_activity, activity: activity1, programme_activity_grouping:, programme:) }
  let!(:activity_group_join2) { create(:programme_activity, activity: activity2, programme_activity_grouping:, programme:) }
  let(:unenrolled_user) { create(:user) }
  let(:enrolled_user) {
    user = create(:user)
    create(:user_programme_enrolment, user:, programme:)
    user
  }

  context "user not logged in" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(nil)
      render_inline(described_class.new(
        programme_activity_group_slug: programme_activity_grouping.title,
        title: Faker::Lorem.sentence,
        intro: Cms::Mocks::RichBlocks.as_model
      ))
    end

    it "should render grid" do
      expect(page).to have_css(".community-activity-list__grid")
    end

    it "should render activities" do
      expect(page).to have_css(".community-activity-list__grid-activity", count: 2)
    end

    it "should not have buttons" do
      expect(page).not_to have_css(".govuk-button")
    end
  end

  context "user logged in but not enrolled" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(unenrolled_user)
      render_inline(described_class.new(
        programme_activity_group_slug: programme_activity_grouping.title,
        title: Faker::Lorem.sentence,
        intro: Cms::Mocks::RichBlocks.as_model
      ))
    end

    it "should render grid" do
      expect(page).to have_css(".community-activity-list__grid")
    end

    it "should render activities" do
      expect(page).to have_css(".community-activity-list__grid-activity", count: 2)
    end

    it "should not have buttons" do
      expect(page).not_to have_css(".govuk-button")
    end
  end

  context "user logged in and enrolled but not selected an activity" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(enrolled_user)
      render_inline(described_class.new(
        programme_activity_group_slug: programme_activity_grouping.title,
        title: Faker::Lorem.sentence,
        intro: Cms::Mocks::RichBlocks.as_model
      ))
    end

    it "should render grid" do
      expect(page).to have_css(".community-activity-list__grid")
    end

    it "should render activities" do
      expect(page).to have_css(".community-activity-list__grid-activity", count: 2)
    end

    it "should have choose activity buttons" do
      expect(page).to have_css(".govuk-button", text: /Choose Activity/, count: 2)
    end
  end

  context "user logged in and enrolled and has selected an activity" do
    let!(:achievement) { create(:achievement, activity: activity2, user: enrolled_user) }

    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(enrolled_user)
      render_inline(described_class.new(
        programme_activity_group_slug: programme_activity_grouping.title,
        title: Faker::Lorem.sentence,
        intro: Cms::Mocks::RichBlocks.as_model
      ))
    end

    it "should render grid" do
      expect(page).to have_css(".community-activity-list__grid")
    end

    it "should render activities" do
      expect(page).to have_css(".community-activity-list__grid-activity", count: 2)
    end

    it "should show added label" do
      expect(page).to have_css(".govuk-heading-s", text: "ACTIVITY ADDED", count: 1)
    end

    it "should have a single button to dashboard" do
      expect(page).to have_link("Manage on Dashboard", href: programme.path, count: 1)
    end
  end
end
