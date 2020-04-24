namespace :new_assesment_eligibility do
  task schedule: :environment do
    batch_size = 50
    interval = 2
    User.find_in_batches(batch_size: batch_size).with_index do |group, batch|
      puts "Processing batch: #{batch}"
      group.each_with_index do |user, index|
        delay = (batch * batch_size * interval) + (index * interval)
        puts "#{user.id} queued in #{delay} seconds"
        NewAssessmentEligibilityJob.set(wait: delay.seconds).perform_later(user.id)
      end
    end
  end
end
