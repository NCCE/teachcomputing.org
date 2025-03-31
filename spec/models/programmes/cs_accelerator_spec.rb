require "rails_helper"

RSpec.describe Programmes::CSAccelerator do
  let(:programme) { create(:cs_accelerator) }
  let(:diagnostic) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:user) { create(:user) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id) }
  let(:exam_activity) { create(:activity, :cs_accelerator_exam) }
  let!(:assessment) { create(:assessment, programme:, activity: exam_activity) }
  let(:programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: exam_activity.id) }
  let(:passed_exam) { create(:completed_achievement, user_id: user.id, activity_id: exam_activity.id) }

  let(:online_courses) { create_list(:activity, 2, :future_learn, credit: 20) }
  let(:face_to_face_courses) { create_list(:activity, 2, :stem_learning, credit: 20) }
  let(:short_face_to_face_course) { create(:activity, :stem_learning, credit: 10) }
  let(:short_face_to_face_achievement) do
    create(:achievement, user_id: user.id, activity_id: short_face_to_face_course.id)
  end
  let(:another_short_face_to_face_course) { create(:activity, :stem_learning, credit: 10) }
  let(:another_short_face_to_face_achievement) do
    create(:achievement, user_id: user.id, activity_id: another_short_face_to_face_course.id)
  end

  let(:setup_partially_complete_certificate) do
    user_programme_enrolment
    activities = [].concat(online_courses, face_to_face_courses)

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
      if activity.category == "online"
        achievement = create(:achievement, user_id: user.id, activity_id: activity.id)
        achievement.complete!
      end
    end
  end

  let(:setup_complete_certificate) do
    user_programme_enrolment

    activities = [].concat(online_courses, face_to_face_courses)

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
      achievement = create(:achievement, user_id: user.id, activity_id: activity.id)
      achievement.complete!
    end
  end

  let(:setup_one_short_f2f_achievement) do
    user_programme_enrolment
    short_face_to_face_course
    create(:programme_activity, programme_id: programme.id, activity_id: short_face_to_face_course.id)
    short_face_to_face_achievement.complete!
  end

  let(:setup_two_short_f2f_achievements) do
    setup_one_short_f2f_achievement
    another_short_face_to_face_course
    create(:programme_activity, programme_id: programme.id, activity_id: another_short_face_to_face_course.id)
    another_short_face_to_face_achievement = create(:achievement, user_id: user.id,
      activity_id: another_short_face_to_face_course.id)
    another_short_face_to_face_achievement.complete!
  end

  let(:setup_one_online_achievement) do
    user_programme_enrolment
    online_courses
    create(:programme_activity, programme_id: programme.id, activity_id: online_courses[0].id)
    online_achievement = create(:achievement, user_id: user.id, activity_id: online_courses[0].id)
    online_achievement.complete!
  end

  let(:setup_short_f2f_and_online_achievement) do
    setup_one_short_f2f_achievement
    setup_one_online_achievement
  end

  let(:setup_two_online_achievements) do
    activities = online_courses

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
      achievement = create(:achievement, user_id: user.id, activity_id: activity.id)
      achievement.complete!
    end
  end

  describe "#pending_delay" do
    it "should return 7 days" do
      expect(programme.pending_delay).to eq 7.days
    end
  end

  describe "#diagnostic" do
    context "when an associated diagnostic activity exists" do
      it "returns record" do
        programme.activities << diagnostic
        expect(programme.diagnostic).to eq diagnostic
      end
    end

    context "when an associated diagnostic activity doesn't exists" do
      it "returns raises an RecordNotFound" do
        expect do
          programme.diagnostic
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#show_notification_for_test?" do
    context "when a user is not enrolled" do
      before do
        setup_short_f2f_and_online_achievement
        allow(programme).to receive(:enough_credits_for_test?).with(user).and_return(true)
      end

      it "returns false" do
        user.user_programme_enrolments.destroy_all
        expect(programme.show_notification_for_test?(user)).to eq(false)
      end
    end

    context "when the user does not have enough_credits_for_test?" do
      before do
        setup_short_f2f_and_online_achievement
        allow(programme).to receive(:enough_credits_for_test?).with(user).and_return(false)
      end

      it "returns false" do
        expect(programme.show_notification_for_test?(user)).to eq(false)
      end
    end

    context "when the user should be shown the notification" do
      before do
        setup_short_f2f_and_online_achievement
        allow(programme).to receive(:enough_credits_for_test?).with(user).and_return(true)
      end

      it "returns true" do
        expect(programme.show_notification_for_test?(user)).to eq(true)
      end
    end
  end

  describe "#enough_credits_for_test?" do
    context "when the user has not done any activities" do
      it "returns false" do
        expect(programme.enough_credits_for_test?(user)).to eq(false)
      end
    end

    context "when the user has done 1 online activity" do
      before do
        setup_one_online_achievement
      end

      it "returns false" do
        expect(programme.enough_credits_for_test?(user)).to eq(false)
      end
    end

    context "when the user has done 1 short f2f activity" do
      before do
        setup_one_short_f2f_achievement
      end

      it "returns false" do
        expect(programme.enough_credits_for_test?(user)).to eq(false)
      end
    end

    context "when the user has done 2 online activities" do
      before do
        setup_two_online_achievements
      end

      it "returns false" do
        expect(programme.enough_credits_for_test?(user)).to eq(true)
      end
    end

    context "when the user has done 2 short f2f activities" do
      before do
        setup_two_short_f2f_achievements
      end

      it "returns true" do
        expect(programme.enough_credits_for_test?(user)).to eq(true)
      end
    end

    context "when the user has done 1 f2f & 1 online activity" do
      before do
        setup_short_f2f_and_online_achievement
      end

      it "returns true" do
        expect(programme.enough_credits_for_test?(user)).to eq(true)
      end
    end
  end

  describe "#path" do
    it "returns the path for the programme" do
      expect(programme.path).to eq("/certificate/subject-knowledge")
    end
  end

  describe "#enrol_path" do
    it "returns the path for the enrol" do
      expect(programme.enrol_path(user_programme_enrolment: {user_id: "user_id",
                                                             programme_id: "programme_id"})).to eq("/certificate/subject-knowledge/enrol?user_programme_enrolment%5Bprogramme_id%5D=programme_id&user_programme_enrolment%5Buser_id%5D=user_id")
    end
  end

  describe "#programme_title" do
    it "returns correct title" do
      expect(programme.programme_title).to eq("GCSE Computer Science Subject Knowledge")
    end
  end

  describe "#course_achievements" do
    context "when user has no achievements" do
      it "returns empty list" do
        expect(programme.course_achievements(user)).to eq([])
      end
    end

    context "when user has non course achievements" do
      it "does not return other types of achievements" do
        [
          create(:achievement, activity: create(:activity, category: "action"), user: user),
          create(:achievement, activity: create(:activity, category: "assessment"), user: user),
          create(:achievement, activity: create(:activity, category: "community"), user: user),
          create(:achievement, activity: create(:activity, category: "diagnostic"), user: user)
        ].each { create(:programme_activity, programme: programme, activity: _1.activity) }

        expect(programme.course_achievements(user)).to eq([])
      end
    end

    context "when user has course achievements" do
      let(:online_achievement) { create(:achievement, activity: create(:activity, category: "online"), user: user) }
      let(:f2f_achievement) { create(:achievement, activity: create(:activity, category: "face-to-face"), user: user) }

      before do
        [online_achievement, f2f_achievement].each { create(:programme_activity, programme: programme, activity: _1.activity) }
      end

      it "includes online courses" do
        expect(programme.course_achievements(user)).to include(online_achievement)
      end

      it "includes face-to-face courses" do
        expect(programme.course_achievements(user)).to include(f2f_achievement)
      end
    end
  end

  describe "#certificate_name" do
    it "should return its certificate name" do
      expect(programme.certificate_name).to eq "KS3 and GCSE subject knowledge certificate"
    end
  end

  describe "#auto_enrollable?" do
    it "should return true" do
      expect(programme.auto_enrollable?).to be true
    end
  end

  describe "#enrolment_confirmation_required?" do
    it "should return false" do
      expect(programme.enrolment_confirmation_required?).to be false
    end
  end

  describe "#certificate_path" do
    it "should return its certificate path" do
      expect(programme.certificate_path).to eq "/certificate/subject-knowledge/view-certificate"
    end
  end
end
