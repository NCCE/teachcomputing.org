require 'rails_helper'

RSpec.describe ResourcesController do
  let(:redirect_url) { URI.encode_www_form_component('https://ncce.io/Year1') }
  let(:user) { create(:user) }


  describe '#show' do
    before do
      allow_any_instance_of(AuthenticationHelper)
        .to receive(:current_user).and_return(user)
    end

    it 'renders the index template' do
      get resources_redirect_path(redirect_url: redirect_url, year: 1)
      expect(response).to redirect_to('https://ncce.io/Year1')
    end

    it 'queues CsAcceleratorEnrolmentTransitionJob job' do
      expect do
        get resources_redirect_path(redirect_url: redirect_url, year: 1)
      end.to have_enqueued_job(ScheduleUserResourcesFeedbackJob)
    end

    it 'adds resource user record' do
      expect do
        get resources_redirect_path(redirect_url: redirect_url, year: 1)
      end.to change{ResourceUser.count}.by(1)
    end

    context 'when user has already downloaded resource year' do
      before do
        get resources_redirect_path(redirect_url: redirect_url, year: 1)
        get resources_redirect_path(redirect_url: redirect_url, year: 1)
      end

      it 'updated the counter' do 
        resource_year = ResourceUser.find_by(user_id: user.id, resource_year: 1)
        expect(resource_year.counter).to eq(2)
      end
    end

  end
end
