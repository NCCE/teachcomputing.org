require 'rails_helper'

RSpec.describe ProgrammesController do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:user_programme_enrolment) {
                                    create( :user_programme_enrolment,
                                            user_id: user.id,
                                            programme_id: programme.id)
                                  }
  let(:exam_activity) { create(:activity, :cs_accelerator_exam )}
  let(:programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: exam_activity.id) }
  let(:passed_exam) { create(:completed_achievement, user_id: user.id, activity_id: exam_activity.id) }

  describe '#complete' do
    describe 'while certification is not enabled' do
      it 'redirects to home page' do
        get programme_complete_path('cs-accelerator')
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
            get programme_complete_path('programme-missing')
          }.to raise_error(ActiveRecord::RecordNotFound)
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
            programme_activity
            user_programme_enrolment
            passed_exam
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
        end
      end

      describe 'while logged out' do
        before do
          get programme_complete_path('cs-accelerator')
        end

        it 'redirects to login' do
          expect(response).to redirect_to(login_path)
        end
      end
    end
  end
end
