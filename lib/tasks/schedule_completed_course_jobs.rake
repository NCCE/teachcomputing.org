namespace :completed_course_jobs do
  task schedule: :environment do
    if can_run_now?
      User.find_in_batches.with_index do |group, batch|
        puts "Processing batch: #{batch}"
        group.each do |user|
          puts "#{user.id} queued"
          FetchUsersCompletedCoursesFromAchieverJob.perform_later(user)
        end
      end
    end
  end

  def can_run_now?
    now = Time.zone.now
    weekday_working_hours = (now.wday >= 1 && now.wday <= 5 && now.hour >= 8 && now.hour <= 17)
    weekend_midnight = (now.wday.zero? || now.wday == 6) && now.hour == 8
    cli_override = ENV['override_time'].present?
    weekday_working_hours || weekend_midnight || cli_override
  end
end
