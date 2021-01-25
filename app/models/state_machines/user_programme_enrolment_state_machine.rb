class StateMachines::UserProgrammeEnrolmentStateMachine
  include Statesman::Machine

  state :enrolled, initial: true
  state :unenrolled
  state :pending
  state :complete

  transition from: :enrolled, to: %i[unenrolled pending complete]
  transition from: :unenrolled, to: :enrolled
  transition from: :pending, to: %i[complete enrolled]
  transition from: :complete, to: %i[pending enrolled]

  guard_transition(to: :complete) do |programme_enrolment|
    !programme_enrolment.flagged?
  end

  after_transition(to: :complete) do |programme_enrolment|
    CompleteCertificateEmailJob.perform_later(programme_enrolment.user, programme_enrolment.programme)
    ClearAchievementAttachmentsJob.perform_later(programme_enrolment)
  end

  after_transition do |programme_enrolment|
    Achiever::ScheduleCertificateSyncJob.perform_later(programme_enrolment.id)
  end
end
