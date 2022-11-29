require 'rails_helper'

RSpec.describe KickOffEmailsJob, type: :job do
  let(:primary_certificate) { create(:primary_certificate) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:primary) { create(:primary_certificate) }
  let(:secondary) { create(:secondary_certificate) }
  let(:cs_accelerator_enrolment) { create(:user_programme_enrolment, programme_id: cs_accelerator.id) }
  let(:primary_enrolment) { create(:user_programme_enrolment, programme_id: primary.id) }
  let(:secondary_enrolment) { create(:user_programme_enrolment, programme_id: secondary.id) }
  let(:primary_certificate_enrolment) { create(:user_programme_enrolment, programme_id: primary_certificate.id) }
  
  
  describe '#perform' do
  
  context 'when the programme is cs accelerator' do
    it 'sends an email' do
      expect { described_class.perform_now(cs_accelerator_enrolment.id) }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
  
  context 'when the programme is primary' do
    it 'sends an email' do
      expect { described_class.perform_now(primary_enrolment.id) }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
  
  context 'when the programme is secondary' do
    it 'sends an email' do
      expect { described_class.perform_now(secondary_enrolment.id) }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
  
  describe 'jobs to be delivered a month after enrolment' do 
    let(:time) { Time.new(2020, 11, 11, 12, 22) }

    before do
      allow(Time).to receive(:at).and_return(time)
    end
    it 'enques jobs to be delivered later' do
      expect do
        described_class.perform_now(cs_accelerator_enrolment.id)
      end.to have_enqueued_job(ScheduleProgrammeGettingStartedPromptJob).with(cs_accelerator_enrolment.id).at(time)
      expect do
        described_class.perform_now(primary_certificate_enrolment.id)
      end.to have_enqueued_job(ScheduleProgrammeGettingStartedPromptJob).with(primary_certificate_enrolment.id).at(time)
    end
  end 
end
end
