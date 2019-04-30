require 'rails_helper'

RSpec.describe ProgrammesController do
  let(:user) { create(:user) }
  let(:programme) { create(:programme) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id)}

  describe '#show' do
    describe 'while logged in' do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      end

      it 'redirects if not enrolled' do
        get programme_path('programme-101')
        expect(response).to redirect_to(certification_path)
      end

      describe 'and enrolled' do
        before do
          programme
          user_programme_enrolment
          get programme_path('programme-101')
        end

        it 'renders the correct template' do
          expect(response).to render_template('show')
        end

        it 'assigns the correct programme' do
          expect(assigns(:programme)).to eq programme
        end
      end
    end

    describe 'while logged out' do
      before do
        get programme_path('programme-101')
      end

      it 'should redirect to login' do
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
