require "rails_helper"

RSpec.describe "rake badge_update_to_current_academic_year", type: :task do
  let!(:programme) { create(:primary_certificate) }
  let!(:old_cpd_badge) { create(:badge, :active, programme:, academic_year: "2023-24") }
  let!(:new_cpd_badge) { create(:badge, academic_year: "2024-25", programme:, activation_date: Date.new(2024, 9, 1)) }
  let!(:old_completion_badge) { create(:badge, :active, :completion, programme:, academic_year: "2023-24") }
  let!(:new_completion_badge) { create(:badge, :completion, programme:, academic_year: "2023-24", activation_date: Date.new(2024, 10, 1)) }

  context "when day of activation for cpd badge" do
    before do
      travel_to Date.new(2024, 9, 1)
    end

    it "should make new badge active when same trigger_type and programme" do
      task.execute
      new_cpd_badge.reload
      old_cpd_badge.reload
      expect(new_cpd_badge.active).to be true
      expect(old_cpd_badge.active).to be false
    end

    it "should not activate badge of different trigger_type" do
      task.execute
      old_completion_badge.reload
      expect(old_completion_badge.active).to be true
    end
  end

  context "when day of activation for completion badge" do
    before do
      travel_to Date.new(2024, 10, 1)
    end

    it "should make new badge active when same trigger_type and programme" do
      task.execute
      new_completion_badge.reload
      old_completion_badge.reload
      expect(new_completion_badge.active).to be true
      expect(old_completion_badge.active).to be false
    end

    it "should not activate badge of different trigger_type" do
      task.execute
      old_cpd_badge.reload
      expect(old_cpd_badge.active).to be true
    end
  end
end
