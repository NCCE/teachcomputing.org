task schedule_eligible_pending_enrolments: :environment do
  programme = Programme.secondary_certificate

  programme.user_programme_enrolments.in_state(:enrolled).each do |enrolment|
    CertificatePendingTransitionJob.set(wait: 1.minute).perform_later(enrolment.user, programmes: [programme]) if programme.user_meets_completion_requirement?(enrolment.user)
  end
end
