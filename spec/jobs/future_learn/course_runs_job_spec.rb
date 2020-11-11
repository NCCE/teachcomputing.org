require 'rails_helper'

RSpec.describe FutureLearn::CourseRunsJob, type: :job do
  let(:course1_uuid) { '5508d66a-c52a-429b-8ff1-d3fe8518b955' }
  let(:course2_uuid) { 'e0aea4ae-4b94-4dca-bb19-296e8e095a49' }
  let(:course1_run1) { build(:fl_course_run, course_uuid: course1_uuid) }
  let(:course1_run2) { build(:fl_course_run, course_uuid: course1_uuid) }
  let(:course2_run) { build(:fl_course_run, course_uuid: course2_uuid) }
  let(:unknown_course_run) { build(:fl_course_run) }

  before do
    create(:activity, future_learn_course_uuid: course1_uuid)
    create(:activity, future_learn_course_uuid: course2_uuid)

    allow(FutureLearn::Queries::CourseRuns)
      .to receive(:all)
      .and_return([course1_run1, course1_run2, course2_run, unknown_course_run])
  end

  describe '#perform' do
    it 'retrieves all course_runs' do
      described_class.perform_now
      expect(FutureLearn::Queries::CourseRuns).to have_received(:all)
    end

    it 'queues job to check enrolments ignoring courses not in system' do
      expect { described_class.perform_now }
        .to have_enqueued_job(FutureLearn::CourseEnrolmentsJob).exactly(2).times
    end

    it 'queues with correct information' do
      allow(FutureLearn::CourseEnrolmentsJob).to receive(:perform_later)
      described_class.perform_now
      expect(FutureLearn::CourseEnrolmentsJob)
        .to have_received(:perform_later)
        .with(course_uuid: course1_uuid,
              run_uuids: [course1_run1[:uuid], course1_run2[:uuid]])
        .once
      expect(FutureLearn::CourseEnrolmentsJob)
        .to have_received(:perform_later)
        .with(course_uuid: course2_uuid, run_uuids: [course2_run[:uuid]])
        .once
    end
  end
end
