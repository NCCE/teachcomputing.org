task schedule_certificate_sync_to_dynamics: :environment do
  enrolments = UserProgrammeEnrolment.all
  enrolments.each do |enrolment|
    Achiever::ScheduleCertificateSyncJob.set(rand(50).minutes).perform_later(enrolment.id)
  end
end
