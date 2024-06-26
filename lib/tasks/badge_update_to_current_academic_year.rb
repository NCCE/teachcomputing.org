desc "Update badges to the current academic year"
task badge_update_to_current_academic_year: :environment do
  current_academic_year = "#{Date.today.year - 1}-#{Date.today.year % 100}"
  next_academic_year = "#{Date.today.year}-#{(Date.today.year + 1) % 100}"

  badges_to_update = Badge.where(academic_year: current_academic_year)

  begin
    Badge.transaction do
      badges_to_update.each do |old_badge|
        next unless old_badge.activation_date <= Date.today

        programme = old_badge.programme
        new_badge = programme.badges.find_by(academic_year: next_academic_year)

        if new_badge
          # Deactivate the old badge and activate the new badge
          old_badge.update!(active: false)
          new_badge.update!(active: true)
        else
          Rails.logger.warn("Badge for the next academic year #{next_academic_year} not found for programme #{programme.name}.")
        end
      end
    end
  rescue => e
    Rails.logger.error("Failed to update badges: #{e.message}")
  end
end
