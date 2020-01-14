require 'rails_helper'

RSpec.describe StateMachines::AchievementStateMachine do
  let(:achievement) { create(:achievement) }

  describe 'guards' do
    it 'can transition from state enrolled to allowed states' do
      [:in_progress, :complete, :dropped].each do |allowed_state|
        expect { create(:achievement).state_machine.transition_to!(allowed_state) }
          .not_to raise_error
      end
    end

    it 'can transition from state in_progress to allowed states' do
      [:complete, :dropped].each do |allowed_state|
        expect { create(:in_progress_achievement).state_machine.transition_to!(allowed_state) }
          .not_to raise_error
      end
    end

    it 'can transition from state dropped to other states' do
      [:enrolled, :in_progress, :complete].each do |allowed_state|
        expect { create(:dropped_achievement).state_machine.transition_to!(allowed_state) }
          .not_to raise_error
      end
    end

    it 'cannot transition from state in_progress to other states' do
      [:enrolled].each do |disallowed_state|
        expect { create(:in_progress_achievement).state_machine.transition_to!(disallowed_state) }
          .to raise_error(Statesman::TransitionFailedError)
      end
    end

    it 'cannot transition from state complete to other states' do
      [:enrolled, :in_progress, :dropped].each do |disallowed_state|
        expect { create(:completed_achievement).state_machine.transition_to!(disallowed_state) }
          .to raise_error(Statesman::TransitionFailedError)
      end
    end
  end
end
