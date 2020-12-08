require 'rails_helper'

RSpec.describe FutureLearn::Queries::CourseRuns do
  let(:vcr_id_base) { '/future_learn/partners/course_runs' }
  let(:run_uuid) { '545ba924-9e73-4a30-bd54-4fb7dee8b913' }

  describe 'all' do
    it 'returns all the course runs and their data associated with the NCCE organisation' do
      VCR.use_cassette("#{vcr_id_base}/all") do
        result = described_class.all.first
        %i[uuid href title start_time weeks_count course].each do |key|
          expect(result.key?(key)).to eq(true)
        end
      end
    end
  end

  describe 'one' do
    it 'returns the specified run' do
      VCR.use_cassette("#{vcr_id_base}/one") do
        result = described_class.one(run_uuid)

        expect(result[:uuid]).to eq(run_uuid)
        %i[uuid href title start_time weeks_count course].each do |key|
          expect(result.key?(key)).to eq(true)
        end
      end
    end
  end
end
