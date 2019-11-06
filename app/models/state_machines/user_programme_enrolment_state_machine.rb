class StateMachines::UserProgrammeEnrolmentStateMachine
  include Statesman::Machine

  state :enrolled, initial: true
  state :pending
  state :complete

  transition from: :enrolled, to: :pending
  transition from: :enrolled, to: :complete
  transition from: :complete, to: %i[pending enrolled]
end
