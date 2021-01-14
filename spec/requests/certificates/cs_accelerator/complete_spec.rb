require 'rails_helper'

RSpec.describe Certificates::CSAcceleratorController do
  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }
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
    online_achievement.set_to_complete
    face_to_face_achievement.set_to_complete
    exam_programme_activity
    passed_exam
  end

  describe '#complete' do
    context 'when user is logged in' do
      before do
        programme
        allow_any_instance_of(AuthenticationHelper)
          .to receive(:current_user).and_return(user)
      end

      it 'redirects if not enrolled' do
        get complete_cs_accelerator_certificate_path
        expect(response).to redirect_to(cs_accelerator_path)
      end

      context 'when user is enrolled' do
        before do
          user_programme_enrolment
          get complete_cs_accelerator_certificate_path
        end

        it 'redirects if not complete' do
          expect(response).to redirect_to(cs_accelerator_certificate_path)
        end
      end

      context 'when user has completed certificate' do
        before do
          user_programme_enrolment.transition_to(:complete)
          setup_achievements_for_completed_course
          get complete_cs_accelerator_certificate_path
        end

        it 'shows the page if complete' do
          expect(response.status).to eq(200)
        end

        it 'renders the correct template' do
          expect(response).to render_template('complete')
        end

        it 'assigns the programme' do
          expect(assigns(:programme)).to eq(programme)
        end

        it 'assigns the assessments' do
          expect(assigns(:user_programme_assessment)).to be_a(UserProgrammeAssessment)
        end
      end
    end

    describe 'while logged out' do
      before do
        get complete_cs_accelerator_certificate_path
      end

      it 'redirects to login' do
        expect(response).to redirect_to(/register/)
      end
    end
  end
end
