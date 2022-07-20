require 'active_support/inflector'

task detect_unlinked_achievements: :environment do
  # Get all achievements missing a programme_id (including legitimate ones)
  achs = Achievement.where(programme_id: nil).not_in_state(:dropped).with_provider(%w[stem-learning future-learn])

  # For each programme...
  Programme.all.each do |p|
    # Collect those that should have one (i.e. they have a programme_activity)
    achs_missing_programme = achs.select { |ach| ProgrammeActivity.find_by(activity_id: ach.activity_id, programme_id: p.id) }

    next unless achs_missing_programme.present?

    Sentry.capture_message(
      "Found #{achs_missing_programme.count} unlinked #{'achievement'.pluralize(achs_missing_programme.count)} for #{p.slug}: #{achs_missing_programme.pluck(:id).join(', ')}"
    )
  end
end
