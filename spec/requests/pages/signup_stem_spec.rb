require 'rails_helper'

RSpec.describe PagesController do
  let(:user) { create(:user) }

  describe '#signup_stem' do
    context 'with new stem login' do
      before do
        @stem_login_enabled = ENV['STEM_LOGIN_ENABLED']
        ENV['STEM_LOGIN_ENABLED'] = 'true'
      end

      after do
        ENV['STEM_LOGIN_ENABLED'] = @stem_login_enabled
      end
      context 'with a current user' do
        before do
          allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
          get signup_stem_path
        end

        it 'should redirect to the dashboard' do
          expect(response).to redirect_to(dashboard_path)
        end
      end

      context 'without a current user' do
        before do
          get signup_stem_path
        end

        it 'should redirect to stem login' do
          expect(response).to redirect_to("#{ENV.fetch('STEM_OAUTH_SITE')}/user/register?from=NCCE")
        end
      end
    end

    context 'with old stem login' do
      before do
        get signup_stem_path
      end

      it 'should render the iframe template' do
        expect(response).to render_template('pages/signup-stem')
      end
    end
  end
end
