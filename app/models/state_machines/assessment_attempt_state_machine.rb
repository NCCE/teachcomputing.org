class StateMachines::AssessmentAttemptStateMachine
  include Statesman::Machine

  state :commenced, initial: true
  state :passed
  state :failed

  transition from: :commenced, to: :passed
  transition from: :commenced, to: :failed
end
