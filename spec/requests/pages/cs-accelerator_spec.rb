require 'rails_helper'

RSpec.describe PagesController do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:user_programme_enrolment) {
                                    create( :user_programme_enrolment,
                                            user_id: user.id,
                                            programme_id: programme.id)
                                  }

  describe 'GET #cs-accelerator' do
    before do
      programme
    end

    context 'when user is not logged in' do
      before do
        get cs_accelerator_path
      end

      it 'shows the page' do
        expect(response).to render_template('pages/cs-accelerator')
      end
    end


    context 'when user is not enrolled on programme' do
      before do
        allow_any_instance_of(AuthenticationHelper)
            .to receive(:current_user).and_return(user)
        get cs_accelerator_path
      end

      it 'shows the page' do
        expect(response).to render_template('pages/cs-accelerator')
      end
    end

    context 'when user is enrolled on programme' do
      it 'redirects to the programme page' do
        allow_any_instance_of(AuthenticationHelper)
            .to receive(:current_user).and_return(user)
        user_programme_enrolment
        get cs_accelerator_path
        expect(response).to redirect_to(programme_path('cs-accelerator'))
      end
    end
  end
end
