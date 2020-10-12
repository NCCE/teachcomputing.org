require 'rails_helper'

RSpec.describe FutureLearn::CourseRunEnrolmentsJob, type: :job do
  subject(:run_job) do
    described_class.perform_now(course_uuid: course_uuid, run_uuid: run_uuid)
  end

  let(:course_uuid) { '621a6593-9b37-47a8-a9b5-e840e6b66fbe' }
  let(:run_uuid) { 'd2acdb39-f6cb-45da-8c37-681d3b4d2911' }
  let(:membership_id) { '0ea0e41f-5620-4a91-a1c7-2a15ecf16a06' }

  let(:mock_enrolments) do
    [
      {
        run: {
          uuid: run_uuid,
          href: 'https://testapi.com/partners/course_runs/d2acdb39-f6cb-45da-8c37-681d3b4d2911'
        },
        organisation_membership: {
          uuid: membership_id,
          href: 'https://testapi.com/partners/organisation_memberships/0ea0e41f-5620-4a91-a1c7-2a15ecf16a06'
        },
        status: 'active',
        activated_at: '2020-01-16T09:48:01.000Z',
        deactivated_at: nil,
        steps_completed_count: 0,
        steps_completed_ratio: 0.0
      }
    ]
  end

  before do
    allow(FutureLearn::Queries::CourseEnrolments)
      .to receive(:all)
      .and_return(mock_enrolments)
  end

  describe '.perform' do
    context 'when we have future_learn_organisation_membership_uuid in db' do
      before do
        create(
          :user,
          future_learn_organisation_membership_uuid: membership_id
        )
      end

      it 'queues job to update users activity' do
        expect { run_job }
          .to have_enqueued_job(FutureLearn::UpdateUserActivityJob)
          .with(course_uuid: course_uuid, enrolment: mock_enrolments.first)
          .once
      end
    end

    context 'when we do not have future_learn_organisation_membership_uuid in db' do
      it 'queues job to fetch user information' do
        expect { run_job }
          .to have_enqueued_job(FutureLearn::UserInformationJob)
          .with(course_uuid: course_uuid, enrolment: mock_enrolments.first)
          .once
      end
    end
  end
end
