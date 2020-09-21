class StateMachines::UserProgrammeEnrolmentStateMachine
  include Statesman::Machine

  state :enrolled, initial: true
  state :pending
  state :complete

  transition from: :enrolled, to: :pending
  transition from: :enrolled, to: :complete
  transition from: :pending, to: %i[complete enrolled]
  transition from: :complete, to: %i[pending enrolled]

  guard_transition(to: :complete) do |programme_enrolment|
    !programme_enrolment.flagged?
  end

  after_transition(to: :complete) do |programme_enrolment|
    CompleteCertificateEmailJob.perform_later(programme_enrolment.user,
                                               programme_enrolment.programme)
  end
end
