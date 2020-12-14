require 'rails_helper'

RSpec.describe KickOffEmailsJob, type: :job do
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:secondary) { create(:secondary_certificate) }
  let(:cs_accelerator_enrolment) { create(:user_programme_enrolment, programme_id: cs_accelerator.id) }
  let(:secondary_enrolment) { create(:user_programme_enrolment, programme_id: secondary.id) }

  describe '#perform' do
    context 'when the programme is cs accelerator' do
      it 'sends an email' do
        expect { described_class.perform_now(cs_accelerator_enrolment.id) }
          .to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'sends an queues the getting started job' do
        expect do
          described_class.perform_now(cs_accelerator_enrolment.id)
        end.to have_enqueued_job(ScheduleProgrammeGettingStartedPromptJob).with(cs_accelerator_enrolment.user.id, cs_accelerator.id)
      end
    end

    context 'when the programme is secondary' do
      it 'sends an email' do
        expect { described_class.perform_now(secondary_enrolment.id) }
          .to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end
end
