require 'rails_helper'

RSpec.describe FutureLearn::Request do
  let(:vcr_id_base) { "future_learn/partners/requests" }
  let(:endpoint) { 'partners/organisation_memberships' }
  let(:user_id) { '87e2b457-4bcd-4630-970e-01672b4e0365' }

  describe 'with an invalid jwt' do
    before do
      stub_request(:get, "#{ENV.fetch('FL_PARTNERS_URL')}/#{endpoint}/#{user_id}")
        .to_return(status: [401, 'Some unauthorized msg'])
    end

    it 'raises the expected error' do
      expect {
        described_class.run(endpoint, user_id)
      }.to raise_error(Faraday::UnauthorizedError)
    end
  end

  describe 'with an invalid id' do
    it 'raises the expected error' do
      VCR.use_cassette("#{vcr_id_base}/404") do
        expect {
          described_class.run(endpoint, 'wrong')
        }.to raise_error(Faraday::ResourceNotFound)
      end
    end
  end
end
