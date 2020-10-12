require 'rails_helper'

RSpec.describe FutureLearn::UpdateUserActivityJob, type: :job do
  describe '.perform' do
    subject(:run_job) do
      described_class.perform_now(course_uuid: course_uuid,
                                  enrolment: enrolment)
    end

    let(:course_uuid) { '621a6593-9b37-47a8-a9b5-e840e6b66fbe' }
    let(:run_uuid) { 'd2acdb39-f6cb-45da-8c37-681d3b4d2911' }
    let(:membership_id) { '0ea0e41f-5620-4a91-a1c7-2a15ecf16a06' }
    let(:user) do
      create(:user,
             future_learn_organisation_membership_uuid: membership_id)
    end
    let(:achievement) { create(:achievement) }

    let(:enrolment) do
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
    end

    context 'when user has a matching activity' do
      context 'when user is already set as dropped' do
        it 'does not update user achievement' do
          expect { run_job }.not_to change(user, :id)
        end
      end

      context 'when user is already set as complete' do
        it 'does not update user achievement'
      end

      context 'when user has left the run' do
        it 'transitions user to dropped'
      end

      context 'when user has completed the run' do
        it 'transitions user to complete'
      end

      context 'when user has not left or completed' do
        it 'updates progress'
      end
    end

    context 'when user does not have a matching activity' do
      it 'creates an achievement for the user'
    end
  end
end
