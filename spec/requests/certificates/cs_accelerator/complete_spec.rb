require "rails_helper"

RSpec.describe Certificates::CSAcceleratorController do
  let(:user) { create(:user, email: "web@teachcomputing.org") }
  let!(:programme) { create(:cs_accelerator) }
  let(:assessment) { create(:assessment, programme: programme) }
  let(:diagostic_activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:online_course) { create(:activity, :future_learn, credit: 20) }
  let(:online_achievement) { create(:achievement, user_id: user.id, activity_id: online_course.id) }
  let(:face_to_face_course) { create(:activity, :stem_learning, credit: 20) }
  let(:face_to_face_achievement) { create(:achievement, user_id: user.id, activity_id: face_to_face_course.id) }
  let(:exam_activity) { create(:activity, :cs_accelerator_exam) }

  let(:setup_achievements_for_completed_course) do
    assessment
    [online_course, face_to_face_course, diagostic_activity].each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
    end

    online_achievement.complete!
    face_to_face_achievement.complete!

    create(:programme_activity, programme_id: programme.id, activity_id: exam_activity.id)
    create(:completed_achievement, user_id: user.id, activity_id: exam_activity.id)
    create(:completed_assessment_attempt, user:, assessment:)
  end

  describe "#complete" do
    context "when user is logged in" do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      end

      it "redirects if not enrolled" do
        get complete_cs_accelerator_certificate_path
        expect(response).to redirect_to(cs_accelerator_path)
      end

      context "when user is enrolled" do
        let!(:user_programme_enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id) }

        before do
          create(:secondary_certificate)
        end

        it "redirects if not complete" do
          get complete_cs_accelerator_certificate_path
          expect(response).to redirect_to(cs_accelerator_certificate_path)
        end

        context "when user has completed certificate" do
          before do
            setup_achievements_for_completed_course
            user_programme_enrolment.transition_to(:complete)
            get complete_cs_accelerator_certificate_path
          end

          it "shows the page if complete" do
            expect(response).to have_http_status(:ok)
          end

          it "renders the correct template" do
            expect(response).to render_template("complete")
          end

          it "assigns the programme" do
            expect(assigns(:programme)).to eq(programme)
          end

          it "assigns the assessments" do
            expect(assigns(:user_programme_assessment)).to be_a(UserProgrammeAssessment)
          end

          it "asks client not to cache a private page" do
            expect(response.headers["cache-control"]).to eq("no-store")
          end
        end
      end
    end

    describe "while logged out" do
      it "redirects to login" do
        get complete_cs_accelerator_certificate_path
        expect(response).to redirect_to(/auth\/stem\?screen_hint=signup/)
      end
    end
  end
end
