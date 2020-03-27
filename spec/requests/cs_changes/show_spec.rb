require 'rails_helper'

RSpec.describe CsChangesController do
  let(:user) { create(:user) }
  let(:diagnostic_tool_activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:programme) { create(:cs_accelerator) }
  let(:diagnostic_tool_activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:programme_diagnostic) { create(:programme_activity, programme_id: programme.id, activity_id: diagnostic_tool_activity.id) }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
           user_id: user.id,
           programme_id: programme.id)
  end

  describe '#show' do
    describe 'while logged out' do
      before do
        get cs_changes_path
      end

      it 'redirects to login' do
        expect(response).to redirect_to(/register/)
      end
    end

    describe 'while logged in' do
      before do
        programme
        allow_any_instance_of(AuthenticationHelper)
          .to receive(:current_user).and_return(user)
        get cs_changes_path
      end

      it 'redirects if not enrolled' do

        expect(response).to redirect_to(cs_accelerator_path)
      end
    end

    describe 'while logged in and enrolled' do
      before do
        programme_diagnostic
        user_programme_enrolment
        allow_any_instance_of(AuthenticationHelper)
          .to receive(:current_user).and_return(user)
        get cs_changes_path
      end

      it 'renders the template' do
        expect(response).to render_template('show')
      end

      it 'assigns the correct programme' do
        expect(assigns(:programme)).to eq programme
      end

      it 'assigns the online achievements' do
        expect(assigns(:online_achievements)).not_to be nil
      end

      it 'assigns the f2f achievements' do
        expect(assigns(:face_to_face_achievements)).not_to be nil
      end
    end
  end
end
