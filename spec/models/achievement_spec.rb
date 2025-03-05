require "rails_helper"

RSpec.describe Achievement, type: :model do
  include ActiveJob::TestHelper
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :my_learning) }
  let(:face_to_face_activity) { create(:activity, category: "face-to-face") }
  let(:programme) { create(:programme) }
  let(:programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: activity.id) }

  let(:achievement) { create(:achievement, activity_id: activity.id) }
  let(:achievement2) { create(:achievement, activity_id: face_to_face_activity.id) }
  let(:future_learn_achievement) { create(:achievement, :future_learn) }
  let(:completed_achievement) { create(:completed_achievement) }
  let(:diagnostic_activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:diagnostic_achievement) { create(:achievement, activity: diagnostic_activity) }
  let(:community_activity) { create(:activity, :community) }
  let(:community_achievement) { create(:achievement, activity: community_activity) }

  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:primary_certificate) { create(:primary_certificate) }
  let(:achievement_with_passed_programme_id) do
    create(:programme_activity, programme_id: programme.id, activity_id: community_activity.id)
    create(:achievement, activity_id: community_activity.id)
  end

  let(:achievement_with_programme) do
    create(:programme_activity, programme_id: programme.id, activity_id: community_activity.id)
    create(:achievement, activity_id: community_activity.id)
  end

  let(:achievement_with_two_programmes) do
    face_to_face_activity = create(:activity, :stem_learning)
    create(:user_programme_enrolment, programme_id: programme.id, user_id: user.id)
    create(:user_programme_enrolment, programme_id: cs_accelerator.id, user_id: user.id)
    create(:programme_activity, programme_id: programme.id, activity_id: face_to_face_activity.id)
    create(:programme_activity, programme_id: cs_accelerator.id, activity_id: face_to_face_activity.id)
    create(:achievement, activity_id: face_to_face_activity.id, user_id: user.id)
  end

  describe "callbacks" do
    it { is_expected.to callback(:queue_auto_enrolment).after(:commit) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:activity) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:achievement_transitions) }
    it { is_expected.to have_one_attached(:supporting_evidence) }
  end

  describe "validations" do
    before do
      achievement
    end

    it { is_expected.to validate_uniqueness_of(:user_id).case_insensitive.scoped_to(:activity_id) }

    context "valid file" do
      it "is valid" do
        achievement.supporting_evidence.attach(
          io: File.open("spec/support/active_storage/supporting_evidence_test_upload.png"), filename: "test.png", content_type: "image/png"
        )
        expect(achievement.valid?).to be true
      end
    end

    context "invalid file" do
      it "is not valid" do
        achievement.supporting_evidence.attach(
          io: File.open("spec/support/active_storage/supporting_evidence_invalid_test_upload.txt"), filename: "test.txt", content_type: "text/plain"
        )
        expect(achievement.valid?).to be false
      end
    end
  end

  describe "#with_category" do
    before do
      diagnostic_achievement
      achievement
    end

    it "returns the achievements which match the category" do
      expect(Achievement.with_category(achievement.activity.category)).to include(achievement)
    end

    it "omits the achievements which don't match the category" do
      expect(Achievement.with_category(achievement.activity.category)).not_to include(diagnostic_achievement)
    end
  end

  describe "#with_courses" do
    before do
      programme_activity
    end

    it "includes face to face courses" do
      expect(Achievement.with_courses).to include(achievement)
    end

    it "includes online courses" do
      expect(Achievement.with_courses).to include(achievement2)
    end

    it "does not include any other category" do
      expect(Achievement.with_courses).not_to include(community_activity)
    end
  end

  describe "#with_credit" do
    before do
      diagnostic_achievement
      community_achievement
    end

    it "returns the achievements which match the credit" do
      expect(Achievement.with_credit(10)).to include(community_achievement)
    end

    it "omits the achievements which don't match the credit" do
      expect(Achievement.with_credit(10)).not_to include(diagnostic_achievement)
    end
  end

  describe "#without_category" do
    before do
      diagnostic_achievement
      achievement
    end

    it "returns the achievements which match the category" do
      expect(Achievement.without_category(diagnostic_achievement.activity.category)).to include(achievement)
    end

    it "omits the achievements which don't match the category" do
      expect(Achievement.without_category(diagnostic_achievement.activity.category)).not_to include(diagnostic_achievement)
    end
  end

  describe "#with_provider" do
    before do
      achievement2
      future_learn_achievement
    end

    it "returns the achievements which match the provider" do
      expect(Achievement.with_provider("stem-learning")).to include(achievement2)
    end

    it "omits the achievements which don't match the provider" do
      expect(Achievement.with_provider("stem-learning")).not_to include(future_learn_achievement)
    end
  end

  describe "#belonging_to_programme?" do
    context "when programme is nil" do
      it "returns false" do
        expect(achievement.belonging_to_programme?(nil)).to be false
      end
    end

    context "when programme is provided" do
      before do
        programme_activity
      end

      it "returns true if the activity belongs to the programme" do
        expect(achievement.belonging_to_programme?(programme)).to be true
      end

      it "returns false if the activity does not belong to the programme" do
        expect(achievement2.belonging_to_programme?(programme)).to be false
      end
    end
  end

  describe "#complete!" do
    it "when state is not complete" do
      expect { achievement.complete! }
        .to change(achievement, :complete?)
        .from(false).to(true)
    end

    it "will save activity credit to the transition" do
      completed_achievement
      expect(completed_achievement.last_transition.metadata["credit"]).to eq 100
    end

    it "will save extra meta_data to the transition" do
      test_meta = "123"
      achievement.complete!(test: test_meta)
      expect(achievement.last_transition.metadata["test"]).to eq test_meta
    end

    it "when state is complete" do
      achievement.transition_to(:complete)
      expect(achievement.complete!).to be false
    end
  end

  describe "#drop!" do
    it "sets state to dropped" do
      expect { achievement.drop! }
        .to change(achievement, :dropped?)
        .from(false).to(true)
    end

    it "adds metadata if provided" do
      achievement.drop!(left_at: "123456")
      expect(achievement.last_transition.metadata)
        .to eq({"left_at" => "123456"})
    end
  end

  describe "#complete?" do
    it "when state is not complete" do
      expect(achievement.complete?).to be false
    end

    it "when state is complete" do
      expect(completed_achievement.complete?).to be true
    end
  end

  describe "#dropped?" do
    it "returns false if not dropped" do
      expect(achievement.dropped?).to be false
    end

    it "returns true if dropped" do
      dropped_achievement = create(:dropped_achievement)
      expect(dropped_achievement.dropped?).to be true
    end
  end

  describe "state" do
    context "when default" do
      subject { Achievement.in_state(:enrolled) }

      it { is_expected.to include achievement }
    end

    context "when completed" do
      subject { Achievement.in_state(:completed) }

      it { is_expected.not_to include achievement }
    end
  end

  describe "delegate methods" do
    it { is_expected.to delegate_method(:can_transition_to?).to(:state_machine).as(:can_transition_to?) }
    it { is_expected.to delegate_method(:current_state).to(:state_machine).as(:current_state) }
    it { is_expected.to delegate_method(:transition_to).to(:state_machine).as(:transition_to) }
    it { is_expected.to delegate_method(:last_transition).to(:state_machine).as(:last_transition) }
    it { is_expected.to delegate_method(:in_state?).to(:state_machine).as(:in_state?) }

    it { is_expected.to delegate_method(:title).to(:activity).as(:title) }
    it { is_expected.to delegate_method(:stem_activity_code).to(:activity).as(:stem_activity_code) }
    it { is_expected.to delegate_method(:slug).to(:activity).as(:slug) }
  end

  describe "destroy" do
    before do
      achievement
      achievement.transition_to(:complete)
    end

    it "deletes transitions" do
      expect { achievement.destroy }.to change(AchievementTransition, :count).by(-1)
    end
  end

  describe "#update_progress_and_state" do
    let(:achievement) { create(:achievement) }

    context "when left_at is present" do
      it "sets to dropped" do
        left_at = DateTime.now.to_s
        expect { achievement.update_progress_and_state(0, left_at) }
          .to change(achievement, :dropped?).to(true)
      end

      it "does not set dropped if progress is 60 or over" do
        left_at = DateTime.now.to_s
        achievement.update_progress_and_state(60, left_at)
        expect(achievement.dropped?).to be(false)
      end
    end

    context "when progress is 0" do
      it "sets to enrolled" do
        achievement.update_progress_and_state(0, nil)
        expect(achievement.in_state?(:enrolled)).to be(true)
      end

      it "sets progress to 0" do
        achievement.update_progress_and_state(0, nil)
        expect(achievement.progress).to eq(0)
      end

      it "will enrol if achievement was previously dropped" do
        achievement.transition_to(:dropped)
        expect(achievement.dropped?).to be(true)
        achievement.update_progress_and_state(0, nil)
        expect(achievement.in_state?(:enrolled)).to be(true)
        expect(achievement.progress).to eq(0)
      end
    end

    context "when progress between 1 and 59" do
      it "sets to in progress and updates stored progress when progress is 1" do
        achievement.update_progress_and_state(1, nil)
        expect(achievement.in_state?(:in_progress)).to be(true)
        expect(achievement.progress).to eq(1)
      end

      it "sets to in progress and updates stored progress when progress is 59" do
        achievement.update_progress_and_state(59, nil)
        expect(achievement.in_state?(:in_progress)).to be(true)
        expect(achievement.progress).to eq(59)
      end

      it "sets progress to match value provided" do
        achievement.update_progress_and_state(49, nil)
        expect(achievement.progress).to eq(49)
      end

      it "will set progress if achievement was previously dropped" do
        achievement.transition_to(:dropped)
        expect(achievement.dropped?).to be(true)
        achievement.update_progress_and_state(49, nil)
        expect(achievement.in_state?(:in_progress)).to be(true)
      end
    end

    context "when progress between 60 and 100" do
      let(:achievement) { create(:achievement, activity: create(:activity, credit: 99)) }

      it "sets to complete when progress is 60" do
        achievement.update_progress_and_state(60, nil)
        expect(achievement.complete?).to be(true)
        expect(achievement.last_transition.metadata)
          .to eq({"credit" => 99.0})
        expect(achievement.progress).to eq(60)
      end

      it "sets to complete when progress is 100" do
        achievement.update_progress_and_state(100, nil)
        expect(achievement.complete?).to be(true)
        expect(achievement.last_transition.metadata)
          .to eq({"credit" => 99.0})
        expect(achievement.progress).to eq(100)
      end
    end

    context "when progress is lower than saved progress" do
      let(:achievement) { create(:achievement, progress: 70) }

      it "does not change saved progress value" do
        achievement.update_progress_and_state(60, nil)
        expect(achievement.progress).to eq(70)
      end
    end

    context "when achievement is complete" do
      let(:achievement) { create(:completed_achievement, progress: 70) }

      it "does not change state to dropped" do
        achievement.update_progress_and_state(80, DateTime.now.to_s)
        expect(achievement.complete?).to be(true)
      end

      it "does not revert to in progress" do
        achievement.update_progress_and_state(50, nil)
        expect(achievement.complete?).to be(true)
      end

      it "does update progress" do
        achievement.update_progress_and_state(75, nil)
        expect(achievement.progress).to eq(75)
      end
    end
  end

  describe "#adequate_evidence_provided?" do
    let(:public_copy_evidence) { nil }
    let(:activity) { create(:activity, public_copy_evidence:) }
    let(:evidence) { [] }
    let(:achievement) { create(:achievement, activity:, user:, evidence:) }

    context "when the activity has no specified requirements" do
      it "should return true" do
        expect(achievement.adequate_evidence_provided?).to be true
      end
    end

    context "when the activity requires evidience but none is provided" do
      let(:public_copy_evidence) { [{brief: "Do some stuff"}] }
      let(:evidence) { [] }

      it "should return false" do
        expect(achievement.adequate_evidence_provided?).to be false
      end
    end

    context "when the activity requires evidience and it is provided" do
      let(:public_copy_evidence) { [{brief: "Do some stuff"}] }
      let(:evidence) { "Evidence? I need evidence to pass the validation!" }

      it "should return true" do
        expect(achievement.adequate_evidence_provided?).to be true
      end
    end
  end

  describe "#transition_community_to_complete" do
    let(:self_verification_info) { nil }
    let(:activity) { create(:activity, self_verification_info:) }
    let(:evidence) { [] }
    let(:achievement) { create(:achievement, activity:, user:, evidence:) }

    it "transitions an achievement to complete" do
      achievement.transition_community_to_complete

      expect(achievement.complete?).to be true
    end

    context "when self verification info is provided" do
      let(:evidence) { ["first step", "second step", "third step"] }
      it "is included in the metadata" do
        achievement.transition_community_to_complete

        expect(achievement.last_transition.metadata["evidence"].present?).to be true
        expect(achievement.last_transition.metadata["evidence"]).to eq(["first step", "second step", "third step"])
      end
    end
  end

  describe "#initial_state" do
    it "should be enrolled" do
      expect(described_class.send(:initial_state)).to eq "enrolled"
    end
  end

  describe "#transition_class" do
    it "should be AchievementTransition" do
      expect(described_class.send(:transition_class)).to eq AchievementTransition
    end
  end

  describe "after save" do
    let!(:activity) { create(:activity) }
    let!(:cs_accelerator) { create(:cs_accelerator) }
    let!(:programme_activity) { create(:programme_activity, programme: cs_accelerator, activity:) }
    let!(:achievement) { build(:achievement, activity:) }

    it "should trigger auto enroll job" do
      expect(AutoEnrolJob).to receive(:perform_later)
      achievement.save
    end
  end
end
