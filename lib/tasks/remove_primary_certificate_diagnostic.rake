namespace :diagnostic do
  desc 'Remove primary certificate diagnostic'

  task remove_primary_certificate_diagnostic: :environment do
    activity = Activity.find_by(slug: 'primary-certificate-diagnostic')
    activity.destroy
    puts 'Done'
  end
end
