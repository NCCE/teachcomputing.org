class StateMachines::AchievementStateMachine
  include Statesman::Machine

  state :commenced, initial: true
  state :complete
  state :dropped

  transition from: :commenced, to: :complete
  transition from: :commenced, to: :dropped
  transition from: :dropped, to: [:commenced, :complete]

  before_transition(from: :commenced, to: :complete) do |achievement, _transition|
  end
end
