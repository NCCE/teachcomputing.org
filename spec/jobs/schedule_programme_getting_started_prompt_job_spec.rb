require 'rails_helper'

RSpec.describe ScheduleProgrammeGettingStartedPromptJob, type: :job do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:achievement) { create(:achievement, programme: programme, user: user) }


  describe '#perform' do
    it 'sends an email' do
      pending("Pending email content")
      expect { ScheduleProgrammeGettingStartedPromptJob.perform_now(user.id, programme.id) }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'doesn\'t send an email if they have an achievement' do
      achievement
      expect { ScheduleProgrammeGettingStartedPromptJob.perform_now(user.id, programme.id) }
        .not_to change { ActionMailer::Base.deliveries.count }
    end
  end
end
