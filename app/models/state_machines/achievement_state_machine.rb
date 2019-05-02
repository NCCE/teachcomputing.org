class StateMachines::AchievementStateMachine
  include Statesman::Machine

  state :commenced, initial: true
  state :complete

  transition from: :commenced, to: :complete

  before_transition(from: :commenced, to: :complete) do |achievement, _transition|
  end
end
