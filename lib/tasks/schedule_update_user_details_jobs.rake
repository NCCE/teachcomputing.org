namespace :update_user_details_jobs do
  task schedule: :environment do
    User.find_in_batches.with_index do |group, batch|
      puts "Processing batch: #{batch}"
      group.each do |user|
        puts "#{user.id} queued"
        UpdateUsersDetailsFromAchieverJob.perform_now(user)
      end
    end
  end
end
