require "rails_helper"

RSpec.describe ScheduleProgrammeGettingStartedPromptJob, type: :job do
  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }
  let(:enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id) }
  let(:activity) { create(:activity, programme_activities: [create(:programme_activity, programme:)]) }
  let(:achievement) { create(:achievement, activity:, user: user) }

  let(:programme_primary) { create(:primary_certificate) }
  let(:enrolment_primary) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme_primary.id) }
  let(:activity_primary) { create(:activity, programme_activities: [create(:programme_activity, programme: programme_primary)]) }
  let(:achievement_primary) { create(:achievement, activity: activity_primary, user: user) }

  let(:programme_secondary) { create(:secondary_certificate) }
  let(:enrolment_secondary) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme_secondary.id) }
  let(:activity_secondary) { create(:activity, programme_activities: [create(:programme_activity, programme: programme_secondary)]) }
  let(:achievement_secondary) { create(:achievement, activity: activity_secondary, user: user) }

  describe "#perform" do
    it "sends an email" do
      expect { ScheduleProgrammeGettingStartedPromptJob.perform_now(enrolment.id) }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "doesn't send an email if they have an achievement" do
      achievement
      expect { ScheduleProgrammeGettingStartedPromptJob.perform_now(enrolment.id) }
        .not_to change { ActionMailer::Base.deliveries.count }
    end

    it "doesn't send a primary certificate inactive prompt email if they have an achievement" do
      achievement_primary
      expect { ScheduleProgrammeGettingStartedPromptJob.perform_now(enrolment_primary.id) }
        .not_to change { ActionMailer::Base.deliveries.count }
    end

    it "should send an email to primary certificate if no achievement" do
      expect { ScheduleProgrammeGettingStartedPromptJob.perform_now(enrolment_primary.id) }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "doesn't send a secondary certificate inactive prompt email if they have an achievement" do
      achievement_secondary
      expect { ScheduleProgrammeGettingStartedPromptJob.perform_now(enrolment_secondary.id) }
        .not_to change { ActionMailer::Base.deliveries.count }
    end

    it "should send an email to secondary certificate if no achievement" do
      expect { ScheduleProgrammeGettingStartedPromptJob.perform_now(enrolment_secondary.id) }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
