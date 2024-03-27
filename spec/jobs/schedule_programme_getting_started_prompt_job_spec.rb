require "rails_helper"

RSpec.describe ScheduleProgrammeGettingStartedPromptJob, type: :job do
  let(:user) { create(:user) }
  let(:enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id) }
  let(:enrolment_2) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme_2.id) }
  let(:programme) { create(:cs_accelerator) }
  let(:programme_2) { create(:primary_certificate) }
  let(:activity) { create(:activity, programme_activities: [create(:programme_activity, programme:)]) }
  let(:activity_2) { create(:activity, programme_activities: [create(:programme_activity, programme: programme_2)]) }
  let(:achievement) { create(:achievement, activity:, user: user) }
  let(:achievement_2) { create(:achievement, activity: activity_2, user: user) }

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
      achievement_2
      expect { ScheduleProgrammeGettingStartedPromptJob.perform_now(enrolment_2.id) }
        .not_to change { ActionMailer::Base.deliveries.count }
    end
  end
end
