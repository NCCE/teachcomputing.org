require 'rails_helper'

RSpec.describe AchievementStateMachine do
  let(:achievement) { create(:achievement) }

  describe "guards" do
    it "can transition from state enrolled to state complete" do
      expect{ achievement.state_machine.transition_to!(:complete) }.not_to raise_error
    end

    it "cannot transition from state complete to state enrolled" do
      achievement.state_machine.transition_to!(:complete)
      expect{ achievement.state_machine.transition_to!(:enrolled) }.to raise_error(Statesman::TransitionFailedError)
    end
  end
end
