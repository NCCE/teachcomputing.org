require 'rails_helper'

RSpec.describe FutureLearn::Queries::CourseEnrolments do
  let(:vcr_id_base) { '/future_learn/partners/course_enrolments' }
  let(:run_uuid) { '545ba924-9e73-4a30-bd54-4fb7dee8b913' }

  describe 'all' do
    it 'returns hash of enrolments for the course runs' do
      VCR.use_cassette("#{vcr_id_base}/all") do
        enrolment = described_class.all(run_uuid).first

        %i[run organisation_membership status activated_at deactivated_at
           steps_completed_count steps_completed_ratio].each do |key|
          expect(enrolment.key?(key)).to eq(true)
        end

        %i[uuid href].each do |key|
          expect(enrolment[:run].key?(key)).to eq(true)
        end

        %i[uuid href].each do |key|
          expect(enrolment[:organisation_membership].key?(key)).to eq(true)
        end
      end
    end
  end
end
