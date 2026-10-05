namespace :partly_complete_emails do
  desc "Queues the CPD-complete, community-incomplete nudge check for every enrolled certificate user"
  task send: :environment do
    [Programme.primary_certificate, Programme.secondary_certificate].each do |programme|
      programme.user_programme_enrolments.in_state(:enrolled).find_each do |enrolment|
        CompletedCpdButNotActivitiesJob.perform_later(enrolment.user_id, programme.id)
      end
    end
  end
end
