require 'rails_helper'

RSpec.describe WelcomeController do
  let(:user) { create(:user) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:primary_certificate) { create(:primary_certificate) }

  describe '#show' do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      get welcome_path
    end

    it 'renders the correct template' do
      expect(response).to render_template('show')
    end

    # it 'assigns the cs_accelerator programme' do
    #   expect(assigns(:cs_accelerator)).to eq primary_certificate
    # end

    # it 'assigns the cs_accelerator programme' do
    #   expect(assigns(:primary_certificate)).to eq cs_accelerator
    # end
  end
end
