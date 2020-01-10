class StateMachines::AchievementStateMachine
  include Statesman::Machine

  state :enrolled, initial: true
  state :step_1
  state :step_2
  state :complete
  state :dropped

  transition from: :enrolled, to: [:step_1, :step_2, :complete, :dropped]
  transition from: :step_1, to: [:step_2, :complete, :dropped]
  transition from: :step_2, to: [:complete, :dropped]
  transition from: :dropped, to: [:enrolled, :complete, :step_1, :step_2]
end
