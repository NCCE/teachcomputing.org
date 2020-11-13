require 'rails_helper'

RSpec.describe FutureLearn::UpdateOrganisationMembershipsJob, type: :job do
  let(:run_with_enrolments) { build(:fl_course_run) }
  let(:run_with_enrolments2) { build(:fl_course_run) }
  let(:missing_course_run) { build(:fl_course_run) }
  let(:ignored_course_run) { build(:fl_course_run) }

  let(:unknown_membership_id) { '5508d66a-c52a-429b-8ff1-d3fe8518b955' }
  let(:known_membership_id) { 'e0aea4ae-4b94-4dca-bb19-296e8e095a49' }

  let(:run_enrolments) do
    [
      build(:fl_enrolment,
            run_uuid: run_with_enrolments[:uuid],
            membership_uuid: unknown_membership_id),
      build(:fl_enrolment,
            run_uuid: run_with_enrolments[:uuid],
            membership_uuid: known_membership_id)

    ]
  end

  let(:run_enrolments2) do
    [
      build(:fl_enrolment,
            run_uuid: run_with_enrolments[:uuid],
            membership_uuid: unknown_membership_id)
    ]
  end

  before do
    create(:activity, future_learn_course_uuid: run_with_enrolments[:course][:uuid])
    create(:activity, future_learn_course_uuid: run_with_enrolments2[:course][:uuid])

    allow(FutureLearn::Queries::CourseRuns)
      .to receive(:all)
      .and_return([run_with_enrolments, run_with_enrolments2, missing_course_run, ignored_course_run])

    allow(Raven).to receive(:capture_message)

    allow(FutureLearn::Queries::CourseEnrolments)
      .to receive(:all)
      .with(run_with_enrolments[:uuid])
      .and_return(run_enrolments)

    allow(FutureLearn::Queries::CourseEnrolments)
      .to receive(:all)
      .with(run_with_enrolments2[:uuid])
      .and_return(run_enrolments2)
  end

  describe '#perform' do
    it 'retrieves all course_runs' do
      described_class.perform_now
      expect(FutureLearn::Queries::CourseRuns).to have_received(:all)
    end

    context 'when course is in TC database' do
      before do
        create(:user, future_learn_organisation_memberships: [known_membership_id])
      end

      it 'gets all enrolments for the course runs' do
        described_class.perform_now
        expect(FutureLearn::Queries::CourseEnrolments)
          .to have_received(:all)
          .with(run_with_enrolments[:uuid])
          .once
        expect(FutureLearn::Queries::CourseEnrolments)
          .to have_received(:all)
          .with(run_with_enrolments2[:uuid])
          .once
      end

      it 'does not get enrolments for missing courses' do
        described_class.perform_now
        expect(FutureLearn::Queries::CourseEnrolments)
          .not_to have_received(:all)
          .with(missing_course_run[:uuid])
        expect(FutureLearn::Queries::CourseEnrolments)
          .not_to have_received(:all)
          .with(ignored_course_run[:uuid])
      end

      it 'queues UserInformationJob once for any unrecognised membership ids' do
        # setup has same membership_id in two course runs but we only want to
        # query the api once for each membership_id we don't know about
        expect { described_class.perform_now }
          .to have_enqueued_job(FutureLearn::UserInformationJob)
          .once
          .with(membership_id: unknown_membership_id)
      end

      it 'does not queue UserInformationJob for known membership ids' do
        expect { described_class.perform_now }
          .not_to have_enqueued_job(FutureLearn::UserInformationJob)
          .once
          .with(membership_id: known_membership_id)
      end
    end

    context 'when CourseEnrolments throws a 401 error' do
      let(:error) { Faraday::UnauthorizedError.new('401 error message') }

      before do
        allow(FutureLearn::Queries::CourseEnrolments)
          .to receive(:all)
          .with(run_with_enrolments[:uuid])
          .and_raise(error)
      end

      it 'logs error' do
        described_class.perform_now
        expect(Raven)
          .to have_received(:capture_message)
          .once
          .with('UnauthorizedError checking course enrolments',
                extra: { error: error, run_uuid: run_with_enrolments[:uuid] })
      end

      it 'retries erroring call' do
        described_class.perform_now
        expect(FutureLearn::Queries::CourseEnrolments)
          .to have_received(:all)
          .with(run_with_enrolments[:uuid])
          .exactly(3).times
      end

      it 'still requests other enrolments' do
        described_class.perform_now
        expect(FutureLearn::Queries::CourseEnrolments)
          .to have_received(:all)
          .with(run_with_enrolments2[:uuid])
          .once
      end
    end

    context 'when course is not in TC database' do
      it 'reports course' do
        described_class.perform_now
        expect(Raven)
          .to have_received(:capture_message)
          .once
          .with(
            'FutureLearn course not found during progress update checking',
            extra: {
              course_id: missing_course_run[:course][:uuid],
              course_title: missing_course_run[:title]
            }
          )
      end
    end

    context 'when course is not in TC database and is on ignore list' do
      it 'does not report course' do
        stub_const(
          'FL_PARTNERS_IGNORED_COURSE_UUIDS',
          [ignored_course_run[:course][:uuid]]
        )
        described_class.perform_now
        expect(Raven)
          .not_to have_received(:capture_message)
          .with(
            'FutureLearn course not found during progress update checking',
            extra: {
              course_id: ignored_course_run[:course][:uuid],
              course_title: ignored_course_run[:title]
            }
          )
      end
    end
  end
end
