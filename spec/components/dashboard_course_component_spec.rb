# frozen_string_literal: true

require "rails_helper"

RSpec.describe DashboardCourseComponent, type: :component do
  let(:user) { create(:user) }
  let(:face_to_face_activity) { create(:activity, :stem_learning) }
  let(:online_activity) { create(:activity, :online) }
  let(:remote_activity) { create(:activity, :remote) }
  let(:primary_certificate) { create(:primary_certificate) }
  let(:secondary_certificate) { create(:secondary_certificate) }
  let(:face_to_face_achivement) { create(:achievement, user:, activity: face_to_face_activity) }
  let(:online_achievement) { create(:achievement, user:, activity: online_activity) }
  let(:remote_achievement) { create(:achievement, user:, activity: remote_activity) }
  let!(:programme_activity_face_to_face) { create(:programme_activity, activity: face_to_face_activity, programme: secondary_certificate) }
  let!(:programme_activity_online) { create(:programme_activity, activity: online_activity, programme: secondary_certificate) }
  let!(:programme_activity_remote) { create(:programme_activity, activity: remote_activity, programme: secondary_certificate) }
  let(:achievement) { build(:achievement, :online) }
  let(:course_delegate) do
    Achiever::Course::Delegate.new(
      JSON.parse({
        "Activity.COURSETEMPLATENO": achievement.activity.stem_course_template_no,
        "Delegate.Is_Fully_Attended": "True",
        OnlineCPD: true,
        "Activity.StartDate": "31/01/2023 00:00:00"
      }.to_json, object_class: OpenStruct)
    )
  end

  context "is a face to face achievement" do
    before do
      render_inline(described_class.new(
        achievement: face_to_face_achivement,
        user_course_info: [course_delegate]
      ))
    end

    it "has the achievement title" do
      expect(page).to have_css("a", text: face_to_face_achivement.activity.title)
    end

    it "has the achievement programme" do
      expect(page).to have_css("strong", text: face_to_face_achivement.activity.programmes.first.certificate_name)
    end

    it "has the face to face icon" do
      expect(page).to have_css(".icon-map-pin")
    end

    it "has the face to face course format text" do
      expect(page).to have_css("span", text: "Face to face course")
    end
  end

  context "is an online achievement" do
    before do
      render_inline(described_class.new(
        achievement: online_achievement,
        user_course_info: [course_delegate]
      ))
    end

    it "has the achievement title" do
      expect(page).to have_css("a", text: online_achievement.activity.title)
    end

    it "has the achievement programme" do
      expect(page).to have_css("strong", text: online_achievement.activity.programmes.first.certificate_name)
    end

    it "has the face to face icon" do
      expect(page).to have_css(".icon-online")
    end

    it "has the face to face course format text" do
      expect(page).to have_css("span", text: "Online course")
    end
  end

  context "is a remote achievement" do
    before do
      render_inline(described_class.new(
        achievement: remote_achievement,
        user_course_info: [course_delegate]
      ))
    end

    it "has the achievement title" do
      expect(page).to have_css("a", text: remote_achievement.activity.title)
    end

    it "has the achievement programme" do
      expect(page).to have_css("strong", text: remote_achievement.activity.programmes.first.certificate_name)
    end

    it "has the face to face icon" do
      expect(page).to have_css(".icon-remote")
    end

    it "has the face to face course format text" do
      expect(page).to have_css("span", text: "Live remote course")
    end
  end
end
