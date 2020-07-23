require 'spec_helper'

RSpec.shared_examples_for 'rateable' do |path|
  let(:path) { path }

  describe 'GET #rate' do
    it 'errors for an invalid polarity' do
      expect { get send(path, polarity: :bad, id: 'an_id') }
        .to raise_error(ArgumentError, 'Unexpected polarity: bad')
    end

    it 'makes a request' do
      stub_a_valid_request
      get send(path, polarity: :negative, id: 'an_id')
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:ok)
    end
  end
end
