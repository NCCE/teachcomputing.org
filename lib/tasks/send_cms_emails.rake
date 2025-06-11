namespace :cms_emails do
  desc "Iterates through Strapi email templates and sends to relevant users"
  task send: :environment do
    SendCmsEmailsJob.perform_now
  end
end
