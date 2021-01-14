task schedule_certificate_sync_to_dynamics: :environment do
  enrolments = UserProgrammeEnrolments.in_state(:enrolled).all

  enrolments.each do |enrolment|
    ScheduleCertificateSyncJob.perform_later(enrolment.id)
  end
end
