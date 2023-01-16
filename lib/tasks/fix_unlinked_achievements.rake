task fix_unlinked_achievements: :environment do
  # Get all achievements missing a programme_id (including legitimate ones)
  achs = Achievement.where(programme_id: nil).not_in_state(:dropped).with_provider(%w[stem-learning future-learn])

  # For each programme...
  Programme.all.each do |p|
    puts "Checking: #{p.slug}"

    # Collect those that should have one (i.e. they have a programme_activity), and are on that programme
    achs_missing_programme = achs.select do |ach|
      ProgrammeActivity.find_by(activity_id: ach.activity_id, programme_id: p.id) && UserProgrammeEnrolment.find_by(user_id: ach.user_id, programme_id: p.id)
    end

    next unless achs_missing_programme.present?

    # Assign the correct programme_id
    achs_missing_programme.each do |ach|
      ach.update(programme_id: p.id)
    end

    Rails.logger.warn "Fixed: #{achs_missing_programme.count}"
  end
end
