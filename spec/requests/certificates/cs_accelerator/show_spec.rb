require "rails_helper"

RSpec.describe Certificates::CSAcceleratorController do
  let!(:questionnaire) { create(:csa_enrolment_questionnaire, programme: programme) }
  let(:user) { create(:user, email: "web@teachcomputing.org") }
  let!(:programme) { create(:cs_accelerator) }
  let(:non_enrollable_programme) { create(:programme, slug: "non-enrollable", enrollable: false) }

  let(:assessment) { create(:assessment, programme_id: programme.id) }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
      user_id: user.id,
      programme_id: programme.id)
  end

  let(:diagnostic_tool_activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:diagnostic_achievement) { create(:achievement, user_id: user.id, activity_id: diagnostic_tool_activity.id) }
  let(:online_course) { create(:activity, :future_learn, credit: 20) }
  let(:online_achievement) { create(:achievement, user_id: user.id, activity_id: online_course.id) }
  let(:face_to_face_course) { create(:activity, :stem_learning, credit: 20) }
  let(:face_to_face_achievement) { create(:achievement, user_id: user.id, activity_id: face_to_face_course.id) }
  let(:exam_activity) { create(:activity, :cs_accelerator_exam) }
  let(:exam_programme_activity) do
    create(:programme_activity, programme_id: programme.id, activity_id: exam_activity.id)
  end
  let(:passed_exam) { create(:completed_achievement, user_id: user.id, activity_id: exam_activity.id) }
  let(:completed_assessment_attempt) { create(:completed_assessment_attempt, user:, assessment:) }

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
    context "when user is logged in" do
      before do
        allow_any_instance_of(AuthenticationHelper)
          .to receive(:current_user).and_return(user)
      end

      it "redirects if not enrolled" do
        get cs_accelerator_certificate_path
        expect(response).to redirect_to(cs_accelerator_path)
      end

      context "when user is enrolled" do
        before do
          setup_achievements_for_programme
          get cs_accelerator_certificate_path
        end

        context "when the user has not completed the diagnostic" do
          it "redirects to the diagnostic path" do
            create(:questionnaire_response, user: user, questionnaire: questionnaire)
            get cs_accelerator_certificate_path
            expect(response)
              .to redirect_to(diagnostic_cs_accelerator_certificate_path(:question_1))
          end

          it "redirects to last question completed" do
            user_response = create(:questionnaire_response, user: user, questionnaire: questionnaire)
            user_response.update(current_question: 3)

            get cs_accelerator_certificate_path
            expect(response)
              .to redirect_to(diagnostic_cs_accelerator_certificate_path(:question_3))
          end
        end

        context "when the user has completed the diagnostic" do
          before do
            create(:activity, :community_5)
            create_list(:activity, 3, :community)
            create_list(:activity, 4, :community_20)
            questionnaire_response = create(:questionnaire_response, user: user, questionnaire: questionnaire)
            questionnaire_response.transition_to(:complete)
            get cs_accelerator_certificate_path
          end

          it "renders the correct template" do
            expect(response).to render_template("show")
          end

          it "assigns the correct programme" do
            expect(assigns(:programme)).to eq programme
          end

          it "redirects to complete_path on completion" do
            completed_assessment_attempt
            user_programme_enrolment.transition_to(:complete)

            get cs_accelerator_certificate_path
            expect(response)
              .to redirect_to(complete_cs_accelerator_certificate_path)
          end

          it "asks client not to cache a private page" do
            expect(response.headers["cache-control"]).to eq("no-store")
          end
        end

        context "when the user does not have a diagnostic response" do
          it "renders the correct template" do
            get cs_accelerator_certificate_path
            expect(response).to render_template("show")
          end
        end
      end
    end

    describe "while logged out" do
      before do
        get cs_accelerator_certificate_path
      end

      it "redirects to login" do
        expect(response).to redirect_to(/auth\/stem\?screen_hint=signup/)
      end
    end
  end
end
