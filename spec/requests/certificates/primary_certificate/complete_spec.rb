require "rails_helper"

RSpec.describe Certificates::PrimaryCertificateController do
  let(:user) { create(:user, email: "web@teachcomputing.org") }
  let(:programme) { create(:primary_certificate) }
  let(:assessment) { create(:assessment, programme_id: programme.id) }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
      user_id: user.id,
      programme_id: programme.id)
  end
  let(:diagostic_activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:online_course) { create(:activity, :future_learn, credit: 20) }
  let(:online_achievement) { create(:achievement, user_id: user.id, activity_id: online_course.id) }
  let(:face_to_face_course) { create(:activity, :stem_learning, credit: 20) }
  let(:face_to_face_achievement) { create(:achievement, user_id: user.id, activity_id: face_to_face_course.id) }
  let(:exam_activity) { create(:activity, :cs_accelerator_exam) }
  let(:exam_programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: exam_activity.id) }
  let(:passed_exam) { create(:completed_achievement, user_id: user.id, activity_id: exam_activity.id) }

  let(:setup_achievements_for_programme) do
    assessment
    user_programme_enrolment
    activities = [online_course, face_to_face_course, diagostic_activity]

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
    end
    online_achievement
    face_to_face_achievement
  end

  let(:setup_achievements_for_completed_course) do
    setup_achievements_for_programme
    online_achievement.complete!
    face_to_face_achievement.complete!
    exam_programme_activity
    passed_exam
  end

  describe "#complete" do
    subject { get complete_primary_certificate_path }

    describe "while logged in" do
      before do
        stub_issued_badges(user.id)
        programme
        allow_any_instance_of(AuthenticationHelper)
          .to receive(:current_user).and_return(user)
      end

      it "redirects if not enrolled" do
        subject
        expect(response).to redirect_to(primary_path)
      end

      describe "and enrolled" do
        it "redirects to pending when course pending" do
          user_programme_enrolment.transition_to(:pending)
          subject
          expect(response).to redirect_to(pending_primary_certificate_path)
        end

        it "redirects if not complete" do
          user_programme_enrolment
          subject
          expect(response).to redirect_to(primary_certificate_path)
        end
      end

      describe "and complete" do
        before do
          stub_issued_badges(user.id)
          user_programme_enrolment.transition_to(:complete)
          setup_achievements_for_completed_course
          subject
        end

        it "shows the page if complete" do
          expect(response.status).to eq(200)
        end

        it "renders the correct template" do
          expect(response).to render_template("complete")
        end

        it "assigns the programme" do
          expect(assigns(:programme)).to eq(programme)
        end

        it "asks client not to cache a private page" do
          expect(response.headers["cache-control"]).to eq("no-store")
        end
      end
    end

    describe "while logged out" do
      before do
        subject
      end

      it "redirects to login" do
        expect(response).to redirect_to(/auth\/stem\?screen_hint=signup/)
      end
    end
  end
end
