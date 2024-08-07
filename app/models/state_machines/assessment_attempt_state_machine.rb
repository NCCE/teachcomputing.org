class StateMachines::AssessmentAttemptStateMachine
  include Statesman::Machine

  STATE_COMMENCED = :commenced
  STATE_TIMEDOUT = :timed_out
  STATE_PASSED = :passed
  STATE_FAILED = :failed

  state STATE_COMMENCED, initial: true
  state STATE_TIMEDOUT
  state STATE_PASSED
  state STATE_FAILED

  transition from: STATE_COMMENCED, to: STATE_PASSED
  transition from: STATE_COMMENCED, to: STATE_TIMEDOUT
  transition from: STATE_COMMENCED, to: STATE_FAILED
end
