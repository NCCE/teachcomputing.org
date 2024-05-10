require "rails_helper"

RSpec.describe ProgrammeObjectives::AssessmentPassRequired do
  let(:progress_bar_title) { "foo" }
  let(:progress_bar_path) { "bar" }
  let(:programme) { create(:programme) }
  let(:assessment) { create(:assessment, programme:) }

  subject { described_class.new(assessment:) }

  it_behaves_like "plays programme objective role"

  describe "displayed" do
    it "should return false for progress_bar" do
      expect(subject.objective_displayed_in_progress_bar?).to be false
    end

    it "should return false for body" do
      expect(subject.objective_displayed_in_body?).to be false
    end
  end

  describe "#user_complete?" do
    let(:user) { create(:user) }

    context "when there is no assessment attempt" do
      it "should return false" do
        expect(subject.user_complete?(user)).to be false
      end
    end

    context "when there is a passed assessment attempt" do
      it "should return true" do
        create(:assessment_attempt, assessment:, user:).transition_to(:passed)

        expect(subject.user_complete?(user)).to be true
      end
    end

    context "when there is a not passed assessment attempt" do
      it "should return false" do
        create(:assessment_attempt, assessment:, user:)

        expect(subject.user_complete?(user)).to be false
      end
    end
  end
end
