require 'rails_helper'

RSpec.describe ScheduleProgrammeGettingStartedPromptJob, type: :job do
  let(:user) { create(:user) }
  let(:enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id) }
  let(:programme) { create(:cs_accelerator) }
  let(:achievement) { create(:achievement, programme: programme, user: user) }

  describe '#perform' do
    it 'sends an email' do
      expect { ScheduleProgrammeGettingStartedPromptJob.perform_now(enrolment.id) }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'doesn\'t send an email if they have an achievement' do
      achievement
      expect { ScheduleProgrammeGettingStartedPromptJob.perform_now(enrolment.id) }
        .not_to change { ActionMailer::Base.deliveries.count }
    end
  end
end
