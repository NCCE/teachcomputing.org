require 'rails_helper'

RSpec.describe ProgrammesController do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:assessment) { create(:assessment, programme_id: programme.id) }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
           user_id: user.id,
           programme_id: programme.id)
  end

  let(:diagnostic_tool_activity) { create(:activity, :diagnostic_tool) }
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
    online_achievement
    face_to_face_achievement
  end

  let(:setup_achievements_for_taking_test) do
    setup_achievements_for_programme
    online_achievement.set_to_complete
    face_to_face_achievement.set_to_complete
    activities = [create(:activity, :future_learn, credit: 20), create(:activity, :stem_learning, credit: 20)]

    activities.each do |activity|
      create(:completed_achievement, user_id: user.id, activity_id: activity.id)
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
    end
  end

  let(:one_commenced_test_attempt) do
    setup_achievements_for_taking_test
    create(:assessment_attempt, user_id: user.id, assessment_id: assessment.id)
  end

  let(:one_failed_test_attempt) do
    setup_achievements_for_taking_test
    create(:failed_assessment_attempt, user_id: user.id, assessment_id: assessment.id)
  end

  let(:two_failed_test_attempts) do
    setup_achievements_for_taking_test
    create_list(:failed_assessment_attempt, 2, user_id: user.id, assessment_id: assessment.id)
  end

  let(:two_old_failed_test_attempts) do
    setup_achievements_for_taking_test
    create_list(:failed_assessment_attempt_from_before, 2, user_id: user.id, assessment_id: assessment.id)
  end


  describe '#show' do
    describe 'while certification is not enabled' do
      it 'redirects to home page' do
        get programme_path('cs-accelerator')
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'while certification is enabled' do
      before do
        allow_any_instance_of(described_class)
          .to receive(:certification_enabled?).and_return(true)
      end

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

          it 'assigns the online achievements' do
            expect(assigns(:online_achievements)).to include(online_achievement)
          end

          it 'assigns the face_to_face achievements' do
            expect(assigns(:face_to_face_achievements)).to include(face_to_face_achievement)
          end

          it 'assigns the diagnostic achievement state correctly' do
            expect(assigns(:downloaded_diagnostic)).to eq (false)
          end

          it 'assigns the assessment passed state correctly' do
            expect(assigns(:passed_assessment)).to eq (false)
          end

          it 'assigns the test gate correctly' do
            expect(assigns(:enough_credits_for_test)).to eq (false)
          end

          it 'assigns the test gate correctly' do
            expect(assigns(:enough_credits_for_test)).to eq (false)
          end

          it 'assign the time until user can take the test correctly' do
            expect(assigns(:can_take_test_at)).to eq (nil)
          end

          it 'assign whether user is currently doing a test correctly' do
            expect(assigns(:currently_taking_test)).to eq (nil)
          end

          it 'assigns the number of attempts at test correctly' do
            expect(assigns(:num_attempts)).to eq (0)
          end

          context 'when diagnostic has been downloaded' do
            before do
              diagnostic_achievement.set_to_complete
              get programme_path('cs-accelerator')
            end

            it 'assigns the diagnostic achievement state correctly' do
              expect(assigns(:downloaded_diagnostic)).to eq (true)
            end
          end

          context 'when user can take the test' do
            before do
              setup_achievements_for_taking_test
              get programme_path('cs-accelerator')
            end

            it 'assigns the test gate correctly' do
              expect(assigns(:enough_credits_for_test)).to eq (true)
            end

            it 'assigns the time until user can take the test' do
              expect(assigns(:can_take_test_at)).to eq (0)
            end

            it 'assigns that user is not currently doing a test' do
              expect(assigns(:currently_taking_test)).to eq (false)
            end

            it 'assigns the number of attempts at test correctly' do
              expect(assigns(:num_attempts)).to eq (0)
            end
          end

          context 'when user started the test' do
            before do
              one_commenced_test_attempt
              get programme_path('cs-accelerator')
            end

            it 'assigns the test gate correctly' do
              expect(assigns(:enough_credits_for_test)).to eq (true)
            end

            it 'assigns the time until user can take the test' do
              expect(assigns(:can_take_test_at)).to eq (0)
            end

            it 'assigns whether user is currently doing a test' do
              expect(assigns(:currently_taking_test)).to eq (true)
            end

            it 'assigns the number of attempts at test correctly' do
              expect(assigns(:num_attempts)).to eq (1)
            end
          end

          context 'when user failed the test' do
            before do
              one_failed_test_attempt
              get programme_path('cs-accelerator')
            end

            it 'assigns the test gate correctly' do
              expect(assigns(:enough_credits_for_test)).to eq (true)
            end

            it 'assigns the time until user can take the test' do
              expect(assigns(:can_take_test_at)).to eq (0)
            end

            it 'assigns whether user is currently doing a test' do
              expect(assigns(:currently_taking_test)).to eq (false)
            end

            it 'assigns the number of attempts at test correctly' do
              expect(assigns(:num_attempts)).to eq (1)
            end
          end

          context 'when user failed the test twice' do
            before do
              two_failed_test_attempts
              get programme_path('cs-accelerator')
            end

            it 'assigns the test gate correctly' do
              expect(assigns(:enough_credits_for_test)).to eq (true)
            end

            it 'assigns the time until user can take the test' do
              expect(assigns(:can_take_test_at)).to eq (48.hours)
            end

            it 'assigns the number of attempts at test correctly' do
              expect(assigns(:num_attempts)).to eq (2)
            end
          end

          context 'when user failed the test twice a while ago' do
            before do
              two_old_failed_test_attempts
              get programme_path('cs-accelerator')
            end

            it 'assigns the time until user can take the test' do
              expect(assigns(:can_take_test_at)).to eq (0)
            end

            it 'assigns the number of attempts at test correctly' do
              expect(assigns(:num_attempts)).to eq (2)
            end
          end

          context 'when assessment has been completed' do
            before do
              exam_programme_activity
              passed_exam
              get programme_path('cs-accelerator')
            end

            it 'assigns the diagnostic achievement state correctly' do
              expect(assigns(:passed_assessment)).to eq (true)
            end

            it 'doesn\'t set the time until user can take the test' do
              expect(assigns(:can_take_test_at)).to eq (nil)
            end
          end
        end
      end

      describe 'while logged out' do
        before do
          get programme_path('cs-accelerator')
        end

        it 'redirects to login' do
          expect(response).to redirect_to(login_path)
        end
      end
    end
  end
end
