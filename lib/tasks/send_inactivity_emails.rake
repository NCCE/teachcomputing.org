namespace :inactivity_emails do
  desc 'Sends out all the inactivity emails'
  task send: :environment do
    SendInactivityEmailsJob.perform_now
  end
end
