desc "Update badges to the current academic year"
task badge_update_to_current_academic_year: :environment do
  badges_to_update = Badge.where(activation_date: Time.zone.today)

  begin
    Badge.transaction do
      badges_to_update.each do |new_badge|
        old_badges = Badge.where(programme: new_badge.programme, trigger_type: new_badge.trigger_type, active: true)

        old_badges.each { _1.update(active: false) }
        new_badge.update!(active: true)
      end
    end
  rescue => e
    Rails.logger.error("Failed to update badges: #{e.message}")
  end
end
