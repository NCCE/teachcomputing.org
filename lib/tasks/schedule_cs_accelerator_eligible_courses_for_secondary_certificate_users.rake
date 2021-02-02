task schedule_cs_accelerator_eligible_courses_for_secondary_certificate_users: :environment do
  programme = Programme.secondary_certificate
  programme.user_programme_enrolments.in_state(:enrolled).each do |enrolment|
    CSAcceleratorEligibleCoursesForSecondaryCertificateUserJob.perform_later(enrolment.user.id)
  end
end
