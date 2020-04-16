require 'rails_helper'

RSpec.describe UserProgrammeEnrolment, type: :model do
  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user: user, programme: programme) }

  describe 'associations' do
    it 'belongs to programme' do
      expect(user_programme_enrolment).to belong_to(:programme)
    end

    it 'belongs to user' do
      expect(user_programme_enrolment).to belong_to(:user)
    end

    it 'has many user programme enrolment transitions' do
      expect(user_programme_enrolment).to have_many(:user_programme_enrolment_transitions)
    end

    it 'queues CompleteCertificateEmailJob job' do
      expect do
        user_programme_enrolment
      end.to have_enqueued_job(ScheduleProgrammeGettingStartedPromptJob).with(user.id, programme.id)
    end
  end
end
