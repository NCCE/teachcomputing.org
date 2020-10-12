require 'rails_helper'

RSpec.describe FutureLearn::CourseRunsJob, type: :job do
  let(:mock_runs) do
    [
      OpenStruct.new(
        uuid: 'run1uuid',
        href: 'https://testapi.com/course_runs/run1uuid',
        title: 'Scratch to Python: Moving from Block- to Text-based Programming',
        full_code: nil,
        code: nil,
        start_time: '2019-03-04T00:00:00.000Z',
        weeks_count: 4,
        course: OpenStruct.new(
          uuid: 'course1uuid',
          href: 'https://testapi.com/courses/course1uuid'
        )
      ),

      OpenStruct.new(
        uuid: 'run2uuid',
        href: 'https://testapi.com/course_runs/run2uuid',
        title: 'Scratch to Python: Moving from Block- to Text-based Programming',
        full_code: nil,
        code: nil,
        start_time: '2019-05-21T00:00:00.000Z',
        weeks_count: 4,
        course: OpenStruct.new(
          uuid: 'course1uuid',
          href: 'https://testapi.com/courses/course1uuid'
        )
      ),

      OpenStruct.new(
        uuid: 'run3uuid',
        href: 'https://testapi.com/course_runs/run3uuid',
        title: 'Programming 101: An Introduction to Python for Educators',
        full_code: nil,
        code: nil,
        start_time: '2019-01-07T00:00:00.000Z',
        weeks_count: 4,
        course: OpenStruct.new(
          uuid: 'course2uuid',
          href: 'https://testapi.com/courses/course2uuid'
        )
      ),

      OpenStruct.new(
        uuid: 'run4uuid',
        href: 'https://testapi.com/course_runs/run4uuid',
        title: 'Teaching Programming in Primary Schools',
        full_code: nil,
        code: nil,
        start_time: '2019-03-04T00:00:00.000Z',
        weeks_count: 4,
        course: OpenStruct.new(
          uuid: 'course3uuid',
          href: 'https://testapi.com/courses/course3uuid'
        )
      )
    ]
  end

  before do
    create(:activity, future_learn_course_uuid: 'course1uuid')
    create(:activity, future_learn_course_uuid: 'course2uuid')

    allow(FutureLearn::Queries::CourseRuns)
      .to receive(:all)
      .and_return(mock_runs)

    allow(Raven).to receive(:capture_message)
  end

  describe '#perform' do
    it 'retrieves all course_runs' do
      described_class.perform_now
      expect(FutureLearn::Queries::CourseRuns).to have_received(:all)
    end

    it 'queues job to check enrolments' do
      expect { described_class.perform_now }
        .to have_enqueued_job(FutureLearn::CourseRunEnrolmentsJob).exactly(3).times
    end

    it 'reports any courses not in our records' do
      described_class.perform_now
      expect(Raven)
        .to have_received(:capture_message)
        .once
        .with('FutureLearn course ID not be found during progress update checking: course3uuid')
    end
  end
end
