require 'rails_helper'

RSpec.describe FutureLearn::Request do
  let(:vcr_id_base) { "future_learn/#{endpoint}" }
  let(:endpoint) { 'partners/organisation_memberships/find' }
  let(:user_id) { '87e2b457-4bcd-4630-970e-01672b4e0365' }
  let(:full_endpoint) { "#{ENV.fetch('FL_PARTNERS_URL')}/#{endpoint}?external_learner_id=#{user_id}" }

  before(:each) do
    VCR.turn_on!
  end

  after(:each) do
    VCR.turn_off!
  end

  describe 'with a valid id' do
    it 'returns the expected data for a valid learner' do
      VCR.use_cassette("#{vcr_id_base}/302") do
        resp = described_class.run(endpoint, { external_learner_id: user_id })
        expect(resp).to eq(
          {
            'uuid' => '7f64ee87-5e77-47bb-8736-3fec909ab1a1',
            'href' => 'https://lticourses-api.sandbox.futurelearn.com/partners/organisation_memberships/7f64ee87-5e77-47bb-8736-3fec909ab1a1'
          }
        )
      end
    end
  end

  describe 'with an invalid jwt' do
    before do
      stub_request(:get, full_endpoint)
        .to_return(status: [401, 'Some unauthorized msg'])
    end

    it 'raises the expected error' do
      expect {
        described_class.run(endpoint, { external_learner_id: user_id })
      }.to raise_error(Faraday::UnauthorizedError)
    end
  end

  describe 'with an invalid id' do
    it 'raises the expected error' do
      VCR.use_cassette("#{vcr_id_base}/404") do
        expect {
          described_class.run(endpoint, { external_learner_id: 'wrong' })
        }.to raise_error(Faraday::ResourceNotFound)
      end
    end
  end
end
