require 'rails_helper'

RSpec.describe FutureLearn::UserInformationJob, type: :job do
  let(:tc_user_id) { 'b4b3542b-e51b-4cb6-be49-9cdf112efd0d' }
  let(:course_uuid) { '621a6593-9b37-47a8-a9b5-e840e6b66fbe' }
  let(:fl_membership_id) { '4248b6c4-70c4-4288-acf3-ce620fd73494' }
  let(:enrolment) do
    {
      run: {
        uuid: 'run-uuid',
        href: 'https://testapi.com/partners/course_runs/d2acdb39-f6cb-45da-8c37-681d3b4d2911'
      },
      organisation_membership: {
        uuid: fl_membership_id,
        href: 'https://testapi.com/partners/organisation_memberships/0ea0e41f-5620-4a91-a1c7-2a15ecf16a06'
      },
      status: 'active',
      activated_at: '2020-01-16T09:48:01.000Z',
      deactivated_at: nil,
      steps_completed_count: 0,
      steps_completed_ratio: 0.0
    }
  end

  describe '.perform' do
    before do
      allow(FutureLearn::Queries::OrganisationMemberships)
        .to receive(:one)
        .and_return(mock_org_membership)
    end

    context 'when FL user matches TC user by ID' do
      let!(:user) { create(:user, id: tc_user_id) }
      let(:mock_org_membership) do
        {
          uuid: fl_membership_id,
          href: 'https://testapi.com/partners/organisation_memberships/ef508…',
          external_learner_id: tc_user_id
        }
      end

      it 'calls organisation membership with correct id' do
        described_class.perform_now(course_uuid: course_uuid, enrolment: enrolment)
        expect(FutureLearn::Queries::OrganisationMemberships)
          .to have_received(:one)
          .with(fl_membership_id)
      end

      it 'updates user future_learn_organisation_membership_uuid' do
        expect { described_class.perform_now(course_uuid: course_uuid, enrolment: enrolment) }
          .to change { user.reload.future_learn_organisation_membership_uuid }
          .to(fl_membership_id)
      end

      it 'queues UpdateUserActivityJob' do
        expect { described_class.perform_now(course_uuid: course_uuid, enrolment: enrolment) }
          .to have_enqueued_job(FutureLearn::UpdateUserActivityJob)
          .with(course_uuid: course_uuid, enrolment: enrolment)
          .once
      end
    end

    context 'when FL user matches TC user by email' do
      let!(:user) { create(:user, email: 'testemail@example.com') }

      let(:mock_org_membership) do
        {
          uuid: fl_membership_id,
          href: 'https://testapi.com/partners/organisation_memberships/ef508…',
          external_learner_id: 'testemail@example.com'
        }
      end

      it 'updates user future_learn_organisation_membership_uuid' do
        expect { described_class.perform_now(course_uuid: course_uuid, enrolment: enrolment) }
          .to change { user.reload.future_learn_organisation_membership_uuid }
          .to(fl_membership_id)
      end
    end

    context 'when FL user does not match TC user' do
      let(:mock_org_membership) do
        {
          uuid: fl_membership_id,
          href: 'https://testapi.com/partners/organisation_memberships/ef508…',
          external_learner_id: 'testemail@example.com'
        }
      end

      it 'does not error' do
        expect { described_class.perform_now(course_uuid: course_uuid, enrolment: enrolment) }.not_to raise_error
      end

      it 'does not queue UpdateUserActivityJob' do
        expect { described_class.perform_now(course_uuid: course_uuid, enrolment: enrolment) }
          .not_to have_enqueued_job(FutureLearn::UpdateUserActivityJob)
      end
    end
  end
end
