require 'rails_helper'

RSpec.describe FutureLearn::Request do
  let(:vcr_id_base) { "future_learn/#{endpoint}" }
  let(:endpoint) { 'partners/organisation_memberships/find' }
  let(:user_id) { '87e2b457-4bcd-4630-970e-01672b4e0365' }

  before(:each) do |test|
    VCR.turn_on! unless test.metadata[:no_vcr]
  end

  after(:each) do |test|
    VCR.turn_off! unless test.metadata[:no_vcr]
  end

  describe 'with a valid id' do
    it 'returns the expected data for a valid learner' do
      VCR.use_cassette("#{vcr_id_base}/302") do
        resp = described_class.run(endpoint, { external_learner_id: user_id })
        expect(resp).to eq(
          { 'uuid' => '7f64ee87-5e77-47bb-8736-3fec909ab1a1', 'href' => 'https://lticourses-api.sandbox.futurelearn.com/partners/organisation_memberships/7f64ee87-5e77-47bb-8736-3fec909ab1a1' }
        )
      end
    end
  end

  describe 'when run successively' do
    before do
      stub_request(:get, "#{ENV.fetch('FL_PARTNERS_URL')}/#{endpoint}?external_learner_id=87e2b457-4bcd-4630-970e-01672b4e0365")
    end

    context 'when within the expiry time', no_vcr: true do
      it 're-uses the jwt' do
        described_class.run(endpoint, { external_learner_id: user_id })

        allow(described_class).to receive(:create_jwt).and_call_original
        described_class.run(endpoint, { external_learner_id: user_id })

        expect(described_class).not_to have_received(:create_jwt)
      end
    end

    context 'when outside the expiry time' do
      it 'uses a new jwt', no_vcr: true do
        described_class.run(endpoint, { external_learner_id: user_id })
        allow(described_class).to receive(:create_jwt)

        travel_to Time.now + 15.minutes
        described_class.run(endpoint, { external_learner_id: user_id })

        expect(described_class).to have_received(:create_jwt)
        travel_back
      end
    end
  end

  describe 'with an invalid jwt' do
    before do
      stub_request(:get, "#{ENV.fetch('FL_PARTNERS_URL')}/#{endpoint}?external_learner_id=87e2b457-4bcd-4630-970e-01672b4e0365")
        .to_return(status: [401, 'Some unauthorized msg'])
    end

    it 'raises an error' do
      expect {
        described_class.run(endpoint, { external_learner_id: user_id })
      }.to raise_error(FutureLearn::Errors::AuthorizationError, 'Failed to connect to https://lticourses-api.sandbox.futurelearn.com')
    end
  end

  describe 'with an invalid id' do
    it 'returns an empty hash' do
      VCR.use_cassette("#{vcr_id_base}/404") do
        resp = described_class.run(endpoint, { external_learner_id: 'wrong' })
        expect(resp).to eq({})
      end
    end
  end
end
