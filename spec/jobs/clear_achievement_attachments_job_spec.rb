require "rails_helper"

RSpec.describe ClearAchievementAttachmentsJob, type: :job do
  let(:user) { create(:user) }
  let(:programme) { create(:secondary_certificate) }
  let(:enrolment) { create(:user_programme_enrolment, programme_id: programme.id, user_id: user.id) }
  let(:uploadable_activity) { create(:activity, uploadable: true, programme_activities: [create(:programme_activity, programme:)]) }
  let(:achievement) do
    create(:achievement, :with_supporting_evidence, activity_id: uploadable_activity.id, user_id: user.id)
  end

  describe "#perform" do
    context "when the enrolment is in a state of complete" do
      before do
        enrolment.transition_to(:complete)
        achievement
        ClearAchievementAttachmentsJob.perform_now(enrolment)
      end

      it "clears the attachment for the achievement" do
        achievement.reload
        expect(achievement.supporting_evidence.attached?).to eq false
      end
    end

    context "when the enrolment is not in a state of complete" do
      before do
        achievement
        ClearAchievementAttachmentsJob.perform_now(enrolment)
      end

      it "does not clear the attachment for the achievement" do
        achievement.reload
        expect(achievement.supporting_evidence.attached?).to eq true
      end
    end
  end
end
