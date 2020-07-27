require 'spec_helper'

RSpec.shared_examples_for 'rateable' do |path|
  let(:path) { path }

  describe 'GET #rate' do
    before do
      stub_a_valid_request
    end

    it 'errors for an invalid polarity' do
      expect { get send(path, polarity: :bad, id: :an_id) }
        .to raise_error(ArgumentError, 'Unexpected polarity: bad')
    end

    it 'makes a request and returns the expected response' do
      get send(path, polarity: :negative, id: :an_id)
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body['message']).to eq('Thank you for your feedback!')
      expect(body['data']).to eq({'casted_data' => {}, 'data' => {}, 'errors' => []})
    end

    it 'sets a cookie, with the expected id' do
      get send(path, polarity: :negative, id: :an_id)
      expect(cookies[:ratings]).to eq([:an_id].to_json)

      get send(path, polarity: :negative, id: :another_id)
      expect(cookies[:ratings]).to eq(%i[an_id another_id].to_json)
    end

    it 'prevents re-rating' do
      get send(path, polarity: :negative, id: :an_id) # First request
      get send(path, polarity: :negative, id: :an_id) # Second request
      body = JSON.parse(response.body)
      expect(body['message']).to eq('You have already provided feedback, thanks!')
      expect(body['data']).to eq(nil)
    end
  end
end
