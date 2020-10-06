require 'rails_helper'

RSpec.describe FutureLearn::Connection do
  let(:endpoint) { 'partners/organisation_memberships' }
  let(:user_id) { '87e2b457-4bcd-4630-970e-01672b4e0365' }
  let(:full_endpoint) { "#{ENV.fetch('FL_PARTNERS_URL')}/#{endpoint}/#{user_id}" }

  describe 'when run successively' do
    before do
      stub_request(:get, full_endpoint)
        .to_return(status: 200, body: {}.to_json)
    end

    context 'when within the expiry time' do
      it 're-uses the jwt' do
        FutureLearn::Request.run(endpoint, user_id)

        allow(described_class).to receive(:create_jwt).and_call_original
        FutureLearn::Request.run(endpoint, user_id)

        expect(described_class).not_to have_received(:create_jwt)
      end
    end

    context 'when outside the expiry time' do
      it 'uses a new jwt' do
        FutureLearn::Request.run(endpoint, user_id)

        travel_to Time.now + 20.minutes

        allow(described_class).to receive(:create_jwt).and_call_original
        FutureLearn::Request.run(endpoint, user_id)

        expect(described_class).to have_received(:create_jwt)

        travel_back
      end
    end
  end
end
