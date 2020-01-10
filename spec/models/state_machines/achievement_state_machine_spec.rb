require 'rails_helper'

RSpec.describe StateMachines::AchievementStateMachine do
  let(:achievement) { create(:achievement) }

  describe 'guards' do
    it 'can transition from state enrolled to allowed states' do
      [:step_1, :step_2, :complete, :dropped].each do |allowed_state|
        expect { create(:achievement).state_machine.transition_to!(allowed_state) }
          .not_to raise_error
      end
    end

    it 'can transition from state step_1 to allowed states' do
      [:step_2, :complete, :dropped].each do |allowed_state|
        expect { create(:step_1_achievement).state_machine.transition_to!(allowed_state) }
          .not_to raise_error
      end
    end

    it 'can transition from state step_2 to allowed states' do
      [:complete, :dropped].each do |allowed_state|
        expect { create(:step_2_achievement).state_machine.transition_to!(allowed_state) }
          .not_to raise_error
      end
    end

    it 'can transition from state dropped to other states' do
      [:enrolled, :step_1, :step_2, :complete].each do |allowed_state|
        expect { create(:dropped_achievement).state_machine.transition_to!(allowed_state) }
          .not_to raise_error
      end
    end

    it 'cannot transition from state step_1 to other states' do
      [:enrolled].each do |disallowed_state|
        expect { create(:step_1_achievement).state_machine.transition_to!(disallowed_state) }
          .to raise_error(Statesman::TransitionFailedError)
      end
    end

    it 'cannot transition from state step_2 to other states' do
      [:enrolled, :step_1].each do |disallowed_state|
        expect { create(:step_2_achievement).state_machine.transition_to!(disallowed_state) }
          .to raise_error(Statesman::TransitionFailedError)
      end
    end

    it 'cannot transition from state complete to other states' do
      [:enrolled, :step_1, :step_2, :dropped].each do |disallowed_state|
        expect { create(:completed_achievement).state_machine.transition_to!(disallowed_state) }
          .to raise_error(Statesman::TransitionFailedError)
      end
    end
  end
end
