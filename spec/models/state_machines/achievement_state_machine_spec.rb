require 'rails_helper'

RSpec.describe StateMachines::AchievementStateMachine do
  let(:achievement) { create(:achievement) }

  describe 'guards' do
    it 'can transition from state commenced to state complete' do
      expect { achievement.state_machine.transition_to!(:complete) }
        .not_to raise_error
    end

    it 'cannot transition from state complete to state commenced' do
      achievement.state_machine.transition_to!(:complete)
      expect{ achievement.state_machine.transition_to!(:commenced) }
        .to raise_error(Statesman::TransitionFailedError)
    end
  end
end
