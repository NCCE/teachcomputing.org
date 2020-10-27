require 'rails_helper'

RSpec.describe ProgrammesController do
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
    describe 'while logged in' do
      before do
        programme
        allow_any_instance_of(AuthenticationHelper)
          .to receive(:current_user).and_return(user)
      end

      it 'handles missing programmes' do
        expect do
          get programme_complete_path('programme-missing')
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'redirects if not enrolled' do
        get programme_complete_path('cs-accelerator')
        expect(response).to redirect_to(cs_accelerator_path)
      end

      describe 'and enrolled' do
        before do
          user_programme_enrolment
          get programme_complete_path('cs-accelerator')
        end

        it 'redirects if not complete' do
          expect(response).to redirect_to(programme_path('cs-accelerator'))
        end
      end

      describe 'and complete' do
        before do
          user_programme_enrolment.transition_to(:complete)
          setup_achievements_for_completed_course
          get programme_complete_path('cs-accelerator')
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

        it 'redirects show to complete' do
          get programme_path('cs-accelerator')
          expect(response).to redirect_to(programme_complete_path('cs-accelerator'))
        end
      end
    end

    describe 'while logged out' do
      before do
        get programme_complete_path('cs-accelerator')
      end

      it 'redirects to login' do
        expect(response).to redirect_to(/register/)
      end
    end
  end
end
