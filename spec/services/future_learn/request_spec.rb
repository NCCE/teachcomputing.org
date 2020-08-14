require 'rails_helper'

RSpec.describe FutureLearn::Request do
  let(:vcr_id_base) { "future_learn/#{endpoint}" }
  let(:endpoint) { 'partners/organisation_memberships/find' }
  let(:user_id) { '87e2b457-4bcd-4630-970e-01672b4e0365' }

  before(:all) do
    VCR.turn_on!
  end

  after(:all) do
    VCR.turn_off!
  end

  describe 'a request with a valid id' do
    it 'returns the expected data for a valid learner' do
      VCR.use_cassette("#{vcr_id_base}/302") do
        resp = described_class.run(endpoint, { external_learner_id: user_id })
        expect(resp).to eq(
          { 'uuid' => '7f64ee87-5e77-47bb-8736-3fec909ab1a1', 'href' => 'https://lticourses-api.sandbox.futurelearn.com/partners/organisation_memberships/7f64ee87-5e77-47bb-8736-3fec909ab1a1' }
        )
      end
    end
  end

  describe 'multiple subsequent requests' do
    it 're-use the same jwt' do
      jwt_matcher = lambda do |r1, r2|
        r1.headers['Authorization'] == r2.headers['Authorization']
      end

      VCR.use_cassette("#{vcr_id_base}/jwt_reuse_1", :match_requests_on => [:method, jwt_matcher]) do
        described_class.run(endpoint, { external_learner_id: user_id })
      end

      VCR.use_cassette("#{vcr_id_base}/jwt_reuse_2", :match_requests_on => [:method, jwt_matcher]) do
        described_class.run(endpoint, { external_learner_id: user_id })
      end
    end
  end

  describe 'a request with an invalid id' do
    it 'returns an empty hash' do
      VCR.use_cassette("#{vcr_id_base}/404") do
        resp = described_class.run(endpoint, { external_learner_id: 'wrong' })
        expect(resp).to eq({})
      end
    end
  end
end
