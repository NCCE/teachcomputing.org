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
    !programme_enrolment.flagged? && programme_enrolment.programme.user_meets_completion_requirement?(programme_enrolment.user)
  end

  after_transition(to: :pending) do |enrolment|
    next unless enrolment.programme.send_pending_mail?

    enrolment.programme.mailer.with(user: enrolment.user).pending.deliver_later
  end

  before_transition(to: :complete) do |programme_enrolment, transition|
    # Set the name that should display on the certificate
    transition.metadata["certificate_name"] = programme_enrolment.programme.programme_complete_counter.get_next_number
  end

  after_transition(to: :complete) do |programme_enrolment, transition|
    programme_enrolment.programme.set_user_programme_enrolment_complete_data(programme_enrolment)

    # Keep track of the pathway the user was on at completion
    programme_enrolment.update(completed_pathway_id: programme_enrolment.pathway.id) unless programme_enrolment.pathway.blank?

    CompleteCertificateEmailJob.perform_later(programme_enrolment.user, programme_enrolment.programme)
    ClearAchievementAttachmentsJob.perform_later(programme_enrolment)
  end

  after_transition do |programme_enrolment|
    Achiever::ScheduleCertificateSyncJob.perform_later(programme_enrolment.id)
  end
end
