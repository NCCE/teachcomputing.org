require 'rails_helper'

RSpec.describe ProgrammesController do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:non_enrollable_programme) { create(:programme, slug: 'non-enrollable', enrollable: false) }

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
  let(:exam_activity) { create(:activity, :cs_accelerator_exam )}
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

  describe '#show' do
    describe 'while logged in' do
      before do
        programme
        allow_any_instance_of(AuthenticationHelper)
          .to receive(:current_user).and_return(user)
      end

      it 'handles missing programmes' do
        expect do
          get programme_path('programme-missing')
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'redirects if not enrolled' do
        get programme_path('cs-accelerator')
        expect(response).to redirect_to(cs_accelerator_path)
      end

      it 'handles non-enrollable programme' do
        non_enrollable_programme
        expect do
          get programme_path('non-enrollable')
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      describe 'and enrolled' do
        before do
          setup_achievements_for_programme
          get programme_path('cs-accelerator')
        end

        it 'renders the correct template' do
          expect(response).to render_template('show')
        end

        it 'assigns the correct programme' do
          expect(assigns(:programme)).to eq programme
        end

        it 'assigns the achievements' do
          expect(assigns(:user_programme_achievements)).to be_a(UserProgrammeAchievements)
        end

        it 'assigns the assessments' do
          expect(assigns(:user_programme_assessment)).to be_a(UserProgrammeAssessment)
        end
      end

      describe 'when CSA_10_HOUR_JOURNEY_ENABLED is true' do
        before do
          ENV['CSA_10_HOUR_JOURNEY_ENABLED'] = 'true'
          face_to_face_achievement.transition_to(:dropped)
          setup_achievements_for_programme
          get programme_path('cs-accelerator')
        end

        it 'assigns the online achievements' do
          expect(assigns(:online_achievements)).not_to eq (nil)
        end

        it 'assigns the face to face achievements' do
          expect(assigns(:face_to_face_achievements)).not_to eq (nil)
        end

        it 'does not include dropped achievements' do
          expect(assigns(:face_to_face_achievements).count).to eq (0)
        end

        it 'renders the 10 hour template' do
          expect(response).to render_template('programmes/cs-accelerator/10_hours/show')
        end
      end
    end

    describe 'while logged out' do
      before do
        get programme_path('cs-accelerator')
      end

      it 'redirects to login' do
        expect(response).to redirect_to(/register/)
      end
    end
  end
end
