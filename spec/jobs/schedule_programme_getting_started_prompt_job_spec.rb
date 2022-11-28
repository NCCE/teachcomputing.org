require 'rails_helper'

RSpec.describe ScheduleProgrammeGettingStartedPromptJob, type: :job do
  let(:user) { create(:user) }
  let(:enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id) }
  let(:enrolment_2) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme_2.id) }
  let(:programme) { create(:cs_accelerator) }
  let(:programme_2) { create(:primary_certificate) }
  let(:achievement) { create(:achievement, programme: programme, user: user) }
  let(:achievement_2) { create(:achievement, programme: programme_2, user: user) }

  describe '#perform' do
    it 'sends an email' do
      expect { ScheduleProgrammeGettingStartedPromptJob.perform_now(enrolment.id) }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'sends emails on a specific date when wait time/date is added to the scheduling method' do
      expect { ScheduleProgrammeGettingStartedPromptJob.set(:wait_until => Date.tomorrow.noon).perform_later(enrolment_2.id) }
      .to have_enqueued_job.at(Date.tomorrow.noon)
    end

    it 'sends a primary certificate inactive prompt email' do
      expect { ScheduleProgrammeGettingStartedPromptJob.perform_now(enrolment_2.id) }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'doesn\'t send an email if they have an achievement' do
      achievement
      expect { ScheduleProgrammeGettingStartedPromptJob.perform_now(enrolment.id) }
        .not_to change { ActionMailer::Base.deliveries.count }
    end

    it 'doesn\'t send a primary certificate inactive prompt email if they have an achievement' do
      achievement_2
      expect { ScheduleProgrammeGettingStartedPromptJob.perform_now(enrolment_2.id) }
        .not_to change { ActionMailer::Base.deliveries.count }
    end
  end
end
