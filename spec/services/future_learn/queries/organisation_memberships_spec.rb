require 'rails_helper'

RSpec.describe FutureLearn::Queries::OrganisationMemberships do
  let(:vcr_id_base) { "/future_learn/partners/organisation_memberships" }
  let(:membership_uuid) { "8e89c1b4-d5c0-4208-b4ad-52928f37ab3f" }

  before(:each) do
    VCR.turn_on!
  end

  after(:each) do
    VCR.turn_off!
  end

  describe 'one' do
    it 'returns the specified organisation membership' do
      VCR.use_cassette("#{vcr_id_base}/one") do
        results = described_class.one(membership_uuid)
        expect(results.uuid).to eq(membership_uuid)
        expect(results).to respond_to(:uuid, :href, :learner, :external_learner_id)
      end
    end
  end
end
