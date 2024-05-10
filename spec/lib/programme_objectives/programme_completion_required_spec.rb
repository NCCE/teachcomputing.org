require "rails_helper"

RSpec.describe ProgrammeObjectives::ProgrammeCompletionRequired do
  let(:required_programme) { create(:programme) }
  let(:progress_bar_title) { "foo" }
  let(:progress_bar_path) { "bar" }

  subject { described_class.new(required_programme:, progress_bar_title:, progress_bar_path:) }

  it_behaves_like "plays programme objective role"
  it_behaves_like "plays programme objective progress bar role"

  describe "displayed" do
    it "should return false for body" do
      expect(subject.objective_displayed_in_body?).to be false
    end
  end

  describe "#user_complete?" do
    let(:user) { create(:user) }

    it "should send user_completed? to the required programme" do
      expect(required_programme).to receive(:user_completed?).with(user)

      subject.user_complete?(user)
    end
  end
end
