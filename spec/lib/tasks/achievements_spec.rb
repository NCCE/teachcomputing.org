# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'rake achievements:drop_all_from_future_learn', type: :task do
  it 'drops only the incomplete future-learn achievements' do
    # expect these to be unchanged
    create_list(:achievement, 2, :my_learning)
    create(:dropped_achievement, :future_learn)
    create(:completed_achievement, :future_learn)
    completed_achievement_with_history = create(:achievement, :future_learn)
    completed_achievement_with_history.state_machine.transition_to!(:in_progress)
    completed_achievement_with_history.state_machine.transition_to!(:complete)

    # expect these to be dropped
    create(:achievement, :future_learn)
    create_list(:in_progress_achievement, 3, :future_learn)
    create(:dropped_achievement, :future_learn).state_machine.transition_to!(:enrolled)

    expect { task.execute }.to change(Achievement.in_state(:dropped), :count)
      .by(5)
      .and change(AchievementTransition, :count)
      .by(5)
  end
end
