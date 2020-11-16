require 'rails_helper'

RSpec.describe FutureLearn::UserInformationJob, type: :job do
  let(:tc_user_id) { 'b4b3542b-e51b-4cb6-be49-9cdf112efd0d' }
  let(:fl_membership_id) { '4248b6c4-70c4-4288-acf3-ce620fd73494' }

  describe '.perform' do
    before do
      allow(FutureLearn::Queries::OrganisationMemberships)
        .to receive(:one)
        .and_return(mock_org_membership)
    end

    context 'when API call returns 401 response' do
      let(:mock_org_membership) { {} }
      let(:error_401) { Faraday::UnauthorizedError.new('401 error message') }

      before do
        allow(FutureLearn::Queries::OrganisationMemberships)
          .to receive(:one)
          .and_raise(error_401)
      end

      it 'retries the job' do
        expect do
          described_class.perform_now(membership_id: fl_membership_id)
        end.to have_enqueued_job(described_class).with(membership_id: fl_membership_id)
      end

      it 'receives retry_on 3 times' do
        allow_any_instance_of(described_class).to receive(:executions).and_return(3)
        expect do
          described_class.perform_now(membership_id: fl_membership_id)
        end.to raise_error(error_401)
      end
    end

    context 'when FL user matches TC user by ID' do
      let!(:user) { create(:user, id: tc_user_id) }
      let(:mock_org_membership) do
        build(:fl_organisation_membership,
              uuid: fl_membership_id,
              external_learner_id: tc_user_id)
      end

      it 'calls organisation membership with correct id' do
        described_class.perform_now(membership_id: fl_membership_id)
        expect(FutureLearn::Queries::OrganisationMemberships)
          .to have_received(:one)
          .with(fl_membership_id)
      end

      it 'updates users future_learn_organisation_memberships' do
        expect { described_class.perform_now(membership_id: fl_membership_id) }
          .to change { user.reload.future_learn_organisation_memberships }
          .to([fl_membership_id])
      end

      it 'does not duplicate membership ids' do
        # if we get into this job but another run of the job has already added
        # the id we need to make sure we don't end up with two the same in the
        # array
        user.future_learn_organisation_memberships = [fl_membership_id]
        user.save

        described_class.perform_now(membership_id: fl_membership_id)
        expect(user.reload.future_learn_organisation_memberships)
          .to eq([fl_membership_id])
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
        expect { described_class.perform_now(membership_id: fl_membership_id) }
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
        expect { described_class.perform_now(membership_id: fl_membership_id) }.not_to raise_error
      end

      it 'does not queue UpdateUserActivityJob' do
        expect { described_class.perform_now(membership_id: fl_membership_id) }
          .not_to have_enqueued_job(FutureLearn::UpdateUserActivityJob)
      end
    end
  end
end
