require 'rails_helper'

RSpec.describe ProgrammesController do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:user_programme_enrolment) {
                                    create( :user_programme_enrolment,
                                            user_id: user.id,
                                            programme_id: programme.id)
                                  }

  let(:diagnostic_tool_activity) { create(:activity, :diagnostic_tool) }
  let(:diagnostic_achievement) { create(:achievement, user_id: user.id, activity_id: diagnostic_tool_activity.id) }
  let(:online_course) { create(:activity, :future_learn, credit: 20) }
  let(:online_achievement) { create(:achievement, user_id: user.id, activity_id: online_course.id) }
  let(:face_to_face_course) { create(:activity, :stem_learning, credit: 20) }
  let(:face_to_face_achievement) { create(:achievement, user_id: user.id, activity_id: face_to_face_course.id) }
                                
  let(:setup_achievements) do 
    user_programme_enrolment
    activities = [diagnostic_tool_activity, online_course, face_to_face_course]

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
    end
    online_achievement
    face_to_face_achievement
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
        allow_any_instance_of(ProgrammesController)
          .to receive(:certification_enabled?).and_return(true)
      end

      describe 'while logged in' do
        before do
          programme
          allow_any_instance_of(AuthenticationHelper)
            .to receive(:current_user).and_return(user)
        end

        it 'handles missing programmes' do
          expect {
            get programme_path('programme-missing')
          }.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'redirects if not enrolled' do
          get programme_path('cs-accelerator')
          expect(response).to redirect_to(cs_accelerator_path)
        end

        describe 'and enrolled' do
          before do
            setup_achievements
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

          context 'when diagnostic has been downloaded' do
            before do
              diagnostic_achievement.set_to_complete
              get programme_path('cs-accelerator')
            end

            it 'assigns the diagnostic achievement state correctly' do
              expect(assigns(:downloaded_diagnostic)).to eq (true)
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
