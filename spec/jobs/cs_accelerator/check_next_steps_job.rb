require "rails_helper"

RSpec.describe CS::AcceleratorCheckNextStepsJob, type: :job do
  let(:user) { create(:user) }
  let(:activity) { create(:activity) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: cs_accelerator.id) }
  let(:achievement) { create(:achievement, user_id: user.id, programme_id: cs_accelerator.id) }
  let(:achievement_2) { create(:achievement, user_id: user.id, activity_id: activity.id, programme_id: cs_accelerator.id) }

  describe "#perform" do
    context "when the user is enrolled on CSA" do
      before do
        user
        enrolment
      end

      it "sends online course completion emails" do
        expect { described_class.perform_now(achievement.id) }
          .to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it "sends face to face course completion emails" do
        expect { described_class.perform_now(achievement_2.id) }
          .to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context "when the user has completed CSA" do
      before do
        user
        enrolment.transition_to(:complete)
      end

      it "does not send the online course completion emails" do
        expect { described_class.perform_now(achievement.id) }
          .not_to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it "does not send the face to face course completion emails" do
        expect { described_class.perform_now(achievement_2.id) }
          .not_to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end

  context "when the user is not enrolled on CSA" do
    it "does not send the online course completion emails" do
      expect { described_class.perform_now(achievement.id) }
        .not_to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "does not send the face to face course completion emails" do
      expect { described_class.perform_now(achievement_2.id) }
        .not_to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
