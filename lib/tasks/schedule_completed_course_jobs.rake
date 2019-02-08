namespace :completed_course_jobs do
  task schedule: :environment do
    User.find_in_batches.with_index do |group, batch|
      puts "Processing batch: #{batch}"
      group.each do |user|
        puts "#{user.id} queued"
        FetchUsersCompletedCoursesFromAchiever.perform_later(user)
      end
    end
  end
end
