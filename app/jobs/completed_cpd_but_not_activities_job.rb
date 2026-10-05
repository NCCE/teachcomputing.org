class CompletedCpdButNotActivitiesJob < ApplicationJob
  SUBJECT = "You're so close!".freeze
  MAX_SENDS = 4
  RESEND_INTERVAL = 3.months

  queue_as :default

  def perform(user_id, programme_id)
    user = User.find(user_id)
    programme = Programme.find(programme_id)
    enrolment = user.user_programme_enrolments.find_by(programme_id: programme.id)

    return if enrolment.nil? || !enrolment.in_state?(:enrolled)
    return unless programme.user_completed_cpd_not_community?(user)

    sent_email = SentEmail.find_or_initialize_by(user:, mailer_type: programme.mailer::COMPLETED_CPD_NOT_ACTIVITIES_EMAIL)
    return if sent_email.send_count >= MAX_SENDS
    return if sent_email.last_sent_at.present? && Time.current < sent_email.last_sent_at + RESEND_INTERVAL

    programme.mailer.with(user:).completed_cpd_not_activities.deliver_now

    # Recorded after delivery so a failed send stays due and the next run retries it
    sent_email.update!(subject: SUBJECT, send_count: sent_email.send_count + 1, last_sent_at: Time.current)
  end
end
