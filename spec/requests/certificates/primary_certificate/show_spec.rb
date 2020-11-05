require 'rails_helper'

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
  let(:online_course) { create(:activity, :future_learn, credit: 20) }
  let(:online_achievement) { create(:achievement, user_id: user.id, activity_id: online_course.id) }
  let(:face_to_face_course) { create(:activity, :stem_learning, credit: 20) }
  let(:face_to_face_achievement) { create(:achievement, user_id: user.id, activity_id: face_to_face_course.id) }
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

  describe '#show' do
    context 'when user is logged in' do
      before do
        programme
        allow_any_instance_of(AuthenticationHelper)
          .to receive(:current_user).and_return(user)
      end

      context 'when user is not enrolled' do
        it 'redirects if not enrolled' do
          get primary_certificate_path
          expect(response).to redirect_to(primary_path)
        end
      end

      context 'when user has not completed questionnaire' do
        before do
          setup_achievements_for_programme
        end

        it 'redirects to the diagnostic path' do
          get primary_certificate_path
          expect(response)
            .to redirect_to(diagnostic_primary_certificate_path(:question_1))
        end

        it 'redirects to last question completed' do
          questionnaire = create(:questionnaire, :primary_enrolment_questionnaire)
          create(:questionnaire_response,
                 user: user,
                 questionnaire: questionnaire,
                 current_question: 3)
          get primary_certificate_path
          expect(response)
            .to redirect_to(diagnostic_primary_certificate_path(:question_3))
        end
      end

      context 'when user has completed questionnaire' do
        before do
          setup_achievements_for_programme
          create(:activity, :community_5)
          create_list(:activity, 3, :community)
          create_list(:activity, 4, :community_20)
          questionnaire = create(:questionnaire, :primary_enrolment_questionnaire)
          questionnaire_response = create(:questionnaire_response,
                                          user: user,
                                          questionnaire: questionnaire)
          questionnaire_response.transition_to(:complete)
        end

        it 'renders the correct template' do
          get primary_certificate_path
          expect(response).to render_template('show')
        end

        it 'assigns the correct programme' do
          get primary_certificate_path
          expect(assigns(:programme)).to eq(Programme.primary_certificate)
        end

        it 'assigns the user programme achievements' do
          get primary_certificate_path
          expect(assigns(:user_programme_achievements))
            .to be_a(UserProgrammeAchievements)
        end

        it 'redirects to pending when course pending' do
          user_programme_enrolment.transition_to(:pending)
          get primary_certificate_path
          expect(response).to redirect_to(pending_primary_certificate_path)
        end

        it 'redirects to complete when course complete' do
          user_programme_enrolment.transition_to(:complete)
          get primary_certificate_path
          expect(response).to redirect_to(complete_primary_certificate_path)
        end
      end
    end

    describe 'while logged out' do
      before do
        get primary_certificate_path
      end

      it 'redirects to login' do
        expect(response).to redirect_to(/register/)
      end
    end
  end
end
