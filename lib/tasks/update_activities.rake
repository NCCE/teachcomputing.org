namespace :update_activities do
  task rename_actions: :environment do
    Activity.find_by(slug: 'registered-with-the-national-centre')
            .update(title: 'Created your account with the National Centre for Computing Education')

    Activity.find_by(slug: 'diagnostic-tool')
            .update(title: 'Used the diagnostic tool')
  end
end
