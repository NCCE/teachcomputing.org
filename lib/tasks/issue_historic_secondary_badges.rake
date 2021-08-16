task issue_historic_secondary_badges: :environment do
  programme = Programme.secondary_certificate
  enrolments = programme.user_programme_enrolments

  enrolments.each do |enrolment|
    has_first_stem_achievement = enrolment.user.achievements.in_state(:complete).with_provider('stem-learning').for_programme(programme).count >= 1
    Credly::IssueBadgeJob.perform_later(enrolment.user.id, programme.id) if has_first_stem_achievement
  end
end
