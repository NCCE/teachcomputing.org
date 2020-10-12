require 'rails_helper'

RSpec.describe FutureLearn::Queries::CourseEnrolments do
  let(:vcr_id_base) { "/future_learn/partners/course_enrolments" }
  let(:run_uuid) { "545ba924-9e73-4a30-bd54-4fb7dee8b913" }

  before(:each) do
    VCR.turn_on!
  end

  after(:each) do
    VCR.turn_off!
  end

  describe 'all' do
    it 'returns formatted enrolments for the course runs' do
      VCR.use_cassette("#{vcr_id_base}/all") do
				enrolment = described_class.all(run_uuid).first
        expect(enrolment).to respond_to(:run, :organisation_membership, :status, :activated_at, :deactivated_at, :steps_completed_count, :steps_completed_ratio)
				expect(enrolment.run).to respond_to(:uuid, :href)
				expect(enrolment.organisation_membership).to respond_to(:uuid, :href)
      end
    end
  end
end
