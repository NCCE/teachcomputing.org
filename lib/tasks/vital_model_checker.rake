task vital_model_checker: :environment do
  online_achievements_count = Achievement.with_category("online").where(created_at: (Time.now - 24.hours)..Time.now).count

  Sentry.capture_message("No online achievements created at in the last 24 hours.") if online_achievements_count == 0

  f2f_achievements_count = Achievement.with_category("face-to-face").where(created_at: (Time.now - 24.hours)..Time.now).count

  Sentry.capture_message("No face to face achievements created at in the last 24 hours.") if f2f_achievements_count == 0
end
