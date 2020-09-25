require 'rails_helper'

RSpec.describe FutureLearn::Queries::CourseRuns do
  let(:vcr_id_base) { "/future_learn//partners/course_runs/" }
  let(:full_endpoint) { "#{ENV.fetch('FL_PARTNERS_URL')}/future_learn//partners/course_runs" }

  before(:each) do
    VCR.turn_on!
  end

  after(:each) do
    VCR.turn_off!
  end

  describe 'all' do
    it 'returns all the course runs and their data associated with the NCCE organisation' do
      VCR.use_cassette("#{vcr_id_base}200") do
        expect(described_class.all.first).to respond_to(:uuid, :href, :title, :start_time, :weeks_count)
      end
    end
  end
end
