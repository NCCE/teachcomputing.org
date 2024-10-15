require "rails_helper"

RSpec.describe Certificates::PrimaryCertificateController do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }

  let(:assessment) { create(:assessment, programme_id: programme.id) }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
      user_id: user.id,
      programme_id: programme.id)
  end

  let(:diagnostic_tool_activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:diagnostic_achievement) { create(:achievement, user_id: user.id, activity_id: diagnostic_tool_activity.id) }
  let(:online_course) { create(:activity, :my_learning, credit: 20) }
  let(:online_achievement) { create(:achievement, user_id: user.id, activity_id: online_course.id) }
  let(:face_to_face_course) { create(:activity, :stem_learning, credit: 20) }
  let(:face_to_face_achievement) { create(:achievement, user_id: user.id, activity_id: face_to_face_course.id) }
  let(:exam_activity) { create(:activity, :cs_accelerator_exam) }
  let(:exam_programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: exam_activity.id) }
  let(:passed_exam) { create(:completed_achievement, user_id: user.id, activity_id: exam_activity.id) }
  let(:setup_achievements_for_programme) do
    assessment
    user_programme_enrolment
    activities = [diagnostic_tool_activity, online_course, face_to_face_course]

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
    end
    diagnostic_achievement
    online_achievement
    face_to_face_achievement
  end

  describe "#show" do
    subject { get pending_primary_certificate_path }

    context "when user is logged in" do
      before do
        programme
        allow_any_instance_of(AuthenticationHelper)
          .to receive(:current_user).and_return(user)
      end

      context "when user is not enrolled" do
        it "redirects if not enrolled" do
          subject
          expect(response).to redirect_to(primary_path)
        end
      end

      context "when user is enrolled" do
        before do
          setup_achievements_for_programme
        end

        it "renders the correct template" do
          subject
          expect(response).to render_template(:pending)
        end

        it "assigns the correct programme" do
          subject
          expect(assigns(:programme)).to eq(Programme.primary_certificate)
        end

        it "asks client not to cache a private page" do
          subject
          expect(response.headers["cache-control"]).to eq("no-store")
        end

        it "redirects to complete when course complete" do
          user_programme_enrolment.transition_to(:complete)
          subject
          expect(response).to redirect_to(complete_primary_certificate_path)
        end
      end
    end

    describe "while logged out" do
      before do
        subject
      end

      it "redirects to login" do
        expect(response).to redirect_to(Rails.application.config.stem_account_site)
      end
    end
  end
end
