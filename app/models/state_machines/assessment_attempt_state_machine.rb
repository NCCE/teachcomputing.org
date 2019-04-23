class StateMachines::AssessmentAttemptStateMachine
  include Statesman::Machine

  state :commenced, initial: true
  state :passed

  transition from: :commenced, to: :passed
end
