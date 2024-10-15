# frozen_string_literal: true

require "rails_helper"

RSpec.describe DashboardCourseComponent, type: :component do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, stem_course_template_no: "a4ec99cf-48aa-477c-91c7-958c81d41b54") }
  let(:achievement) { create(:achievement, user:, activity:) }
  let(:programme) { create(:primary_certificate) }
  let!(:programme_activity) { create(:programme_activity, activity: activity, programme: programme) }

  let(:online_activity) { create(:activity, :online) }
  let(:online_achievement) { create(:achievement, user:, activity: online_activity) }
  let!(:programme_activity_online) { create(:programme_activity, activity: online_activity, programme: programme) }

  let(:remote_activity) { create(:activity, :remote) }
  let(:remote_achievement) { create(:achievement, user:, activity: remote_activity) }
  let!(:programme_activity_remote) { create(:programme_activity, activity: remote_activity, programme: programme) }

  let(:completed_achievement) { create(:completed_achievement) }

  let(:course_delegate) do
    Achiever::Course::Delegate.new(JSON.parse({
      "Activity.COURSEOCCURRENCENO": "a4ec99cf-48aa-477c-91c7-958c81d41b54",
      "Activity.COURSETEMPLATENO": "a4ec99cf-48aa-477c-91c7-958c81d41b54",
      "Delegate.Is_Fully_Attended": "True",
      OnlineCPD: false,
      "Delegate.Progress": "157420003",
      "ActivityVenueAddress.VenueName": "National STEM Learning Centre",
      "ActivityVenueAddress.VenueCode": "",
      "ActivityVenueAddress.City": "York",
      "ActivityVenueAddress.PostCode": "YO10 5DD",
      "ActivityVenueAddress.Address.Line1": "University of York",
      "Activity.StartDate": "10/07/2019 00:00:00",
      "Activity.EndDate": "17/07/2019 00:00:00"
    }.to_json, object_class: OpenStruct))
  end

  context "is a face to face achievement" do
    before do
      render_inline(described_class.new(
        achievement: achievement,
        user_course_info: [course_delegate]
      ))
    end

    it "renders the achievement title" do
      expect(page).to have_css("a", text: achievement.activity.title)
    end

    it "renders the achievement programme type" do
      expect(page).to have_css("strong", text: achievement.activity.programmes.first.certificate_name)
    end

    it "renders the face to face icon" do
      expect(page).to have_css(".icon-map-pin")
    end

    it "renders the face to face course format text" do
      expect(page).to have_css("span", text: "Face to face course")
    end

    it "renders the course start date" do
      expect(page).to have_css("strong", text: "10 July 2019, Wednesday 00:00")
    end

    it "renders the course venue" do
      expect(page).to have_text("National STEM Learning Centre")
    end

    it "renders the enrolled date" do
      expect(page).to have_text("Enrolled on #{achievement.created_at.strftime("%b %Y")}")
    end
  end

  context "is an online achievement" do
    before do
      render_inline(described_class.new(
        achievement: online_achievement,
        user_course_info: [course_delegate]
      ))
    end

    it "renders the achievement title" do
      expect(page).to have_css("a", text: online_achievement.activity.title)
    end

    it "renders the achievement programme" do
      expect(page).to have_css("strong", text: online_achievement.activity.programmes.first.certificate_name)
    end

    it "renders the face to face icon" do
      expect(page).to have_css(".icon-online")
    end

    it "renders the face to face course format text" do
      expect(page).to have_css("span", text: "Online course")
    end

    it "does not render the course details" do
      expect(page).to_not have_text("National STEM Learning Centre")
    end

    it "renders the enrolled date" do
      expect(page).to have_text("Enrolled on #{achievement.created_at.strftime("%b %Y")}")
    end
  end

  context "is a remote achievement" do
    before do
      render_inline(described_class.new(
        achievement: remote_achievement,
        user_course_info: [course_delegate]
      ))
    end

    it "renders the achievement title" do
      expect(page).to have_css("a", text: remote_achievement.activity.title)
    end

    it "renders the achievement programme" do
      expect(page).to have_css("strong", text: remote_achievement.activity.programmes.first.certificate_name)
    end

    it "renders the face to face icon" do
      expect(page).to have_css(".icon-remote")
    end

    it "renders the face to face course format text" do
      expect(page).to have_css("span", text: "Live remote course")
    end

    it "does not render the course details" do
      expect(page).to_not have_text("National STEM Learning Centre")
    end

    it "renders the enrolled date" do
      expect(page).to have_text(achievement.created_at.strftime("%b %Y"))
    end
  end

  context "is a remote achievement" do
    before do
      render_inline(described_class.new(
        achievement: completed_achievement,
        user_course_info: [course_delegate]
      ))
    end

    it "renders the completed date" do
      expect(page).to have_text("Completed on #{achievement.created_at.strftime("%b %Y")}")
    end
  end
end
