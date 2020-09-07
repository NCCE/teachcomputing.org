require 'spec_helper'

RSpec.shared_examples_for 'rateable' do |path|
  let(:path) { path }
  let(:user) { create(:user, stem_achiever_contact_no: 'achieverid') }

  describe 'GET #rate' do
    before do
      stub_a_valid_request
      allow_any_instance_of(AuthenticationHelper)
        .to receive(:current_user).and_return(user)
    end

    it 'errors for an invalid polarity' do
      expect { get send(path, polarity: :bad, id: :an_id, user_id: user.id) }
        .to raise_error(ArgumentError, 'Unexpected polarity: bad')
    end

    it 'makes a request and returns the expected response' do
      get send(path, polarity: :negative, id: :an_id, user_id: user.id)
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body['message']).to eq('Thank you for your feedback!')
      expect(body['data']).to eq({ 'casted_data' => {}, 'data' => {}, 'errors' => [] })
    end

    it 'creates cookies with the expected ids' do
      get send(path, polarity: :negative, id: :an_id, user_id: user.id)
      get send(path, polarity: :negative, id: :another_id, user_id: user.id)

      cookie_jar = ActionDispatch::Cookies::CookieJar.build(request, cookies.to_hash)
      expect(cookie_jar.encrypted[:ratings]).to eq(%i[an_id another_id].to_json)
    end

    it 'prevents re-rating' do
      get send(path, polarity: :negative, id: :an_id, user_id: user.id) # First request
      get send(path, polarity: :negative, id: :an_id, user_id: user.id) # Second request
      body = JSON.parse(response.body)
      expect(body['message']).to eq('You have already provided a rating, thanks!')
      expect(body['data']).to eq(nil)
    end
  end
end
