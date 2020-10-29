require 'rails_helper'

RSpec.describe FutureLearn::UserInformationJob, type: :job do
  let(:tc_user_id) { 'b4b3542b-e51b-4cb6-be49-9cdf112efd0d' }
  let(:course_uuid) { '621a6593-9b37-47a8-a9b5-e840e6b66fbe' }
  let(:fl_membership_id) { '4248b6c4-70c4-4288-acf3-ce620fd73494' }
  let(:enrolment) { build(:fl_enrolment, membership_uuid: fl_membership_id) }

  describe '.perform' do
    before do
      allow(FutureLearn::Queries::OrganisationMemberships)
        .to receive(:one)
        .and_return(mock_org_membership)
    end

    context 'when FL user matches TC user by ID' do
      let!(:user) { create(:user, id: tc_user_id) }
      let(:mock_org_membership) do
        build(:fl_organisation_membership,
              uuid: fl_membership_id,
              external_learner_id: tc_user_id)
      end

      it 'calls organisation membership with correct id' do
        described_class.perform_now(course_uuid: course_uuid, enrolment: enrolment)
        expect(FutureLearn::Queries::OrganisationMemberships)
          .to have_received(:one)
          .with(fl_membership_id)
      end

      it 'updates users future_learn_organisation_memberships' do
        expect { described_class.perform_now(course_uuid: course_uuid, enrolment: enrolment) }
          .to change { user.reload.future_learn_organisation_memberships }
          .to([fl_membership_id])
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
        build(:fl_organisation_membership,
              uuid: fl_membership_id,
              external_learner_id: 'testemail@example.com')
      end

      it 'updates user future_learn_organisation_membership_uuid' do
        expect { described_class.perform_now(course_uuid: course_uuid, enrolment: enrolment) }
          .to change { user.reload.future_learn_organisation_memberships }
          .to([fl_membership_id])
      end
    end

    context 'when FL user does not match TC user' do
      let(:mock_org_membership) do
        build(:fl_organisation_membership,
              uuid: fl_membership_id,
              external_learner_id: 'testemail@example.com')
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
