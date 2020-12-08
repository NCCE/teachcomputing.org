require 'rails_helper'

RSpec.describe FutureLearn::Queries::OrganisationMemberships do
  let(:vcr_id_base) { '/future_learn/partners/organisation_memberships' }
  let(:membership_uuid) { '8e89c1b4-d5c0-4208-b4ad-52928f37ab3f' }

  describe 'one' do
    it 'returns the specified organisation membership' do
      VCR.use_cassette("#{vcr_id_base}/one") do
        result = described_class.one(membership_uuid)

        expect(result[:uuid]).to eq(membership_uuid)
        %i[uuid href learner external_learner_id].each do |key|
          expect(result.key?(key)).to eq(true)
        end
      end
    end
  end
end
