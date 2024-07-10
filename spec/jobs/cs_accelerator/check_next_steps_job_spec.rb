require "rails_helper"

RSpec.describe CSAccelerator::CheckNextStepsJob, type: :job do
  let(:user) { create(:user) }
  let!(:cs_accelerator) { create(:cs_accelerator) }
  let(:other_programme) { create(:programme) }
  let(:enrolment) { create(:user_programme_enrolment, user:, programme_id: cs_accelerator.id) }
  let(:activity) { create(:activity) }
  let(:activity_2) { create(:activity, :my_learning) }
  let(:non_csa_activity) { create(:activity) }
  let(:programme_activity) { create(:programme_activity, activity:, programme: cs_accelerator) }
  let(:programme_activity_2) { create(:programme_activity, activity: activity_2, programme: cs_accelerator) }
  let(:non_csa_programme_activity) { create(:programme_activity, activity: non_csa_activity, programme: other_programme) }
  let(:achievement) { create(:achievement, user:, activity:) }
  let(:achievement_2) { create(:achievement, user:, activity: activity_2) }
  let(:non_csa_achievement) { create(:achievement, user:, activity: non_csa_activity) }

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
        allow_any_instance_of(Programmes::CSAccelerator).to receive(:enough_activities_for_test?).with(user).and_return(true)
        allow_any_instance_of(Programmes::CSAccelerator).to receive(:user_meets_completion_requirement?).with(user).and_return(true)
        enrolment.transition_to(:complete)
      end

      it "does not send the online course completion emails" do
        expect { described_class.perform_now(achievement.id) }
          .not_to change { ActionMailer::Base.deliveries.count }
      end

      it "does not send the face to face course completion emails" do
        expect { described_class.perform_now(achievement_2.id) }
          .not_to change { ActionMailer::Base.deliveries.count }
      end
    end
  end

  context "when the user is not enrolled on CSA" do
    it "does not send the online course completion emails" do
      expect { described_class.perform_now(non_csa_achievement.id) }
        .not_to change { ActionMailer::Base.deliveries.count }
    end

    it "does not send the face to face course completion emails" do
      expect { described_class.perform_now(non_csa_achievement.id) }
        .not_to change { ActionMailer::Base.deliveries.count }
    end
  end
end
