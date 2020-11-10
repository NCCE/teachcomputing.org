namespace :secondary_certificate do
  task clear_activities: :environment do
    secondary = Programme.secondary_certificate
    puts "Secondary activities total count #{secondary.programme_activities.count}"
    puts 'Deleting ProgrammeActivities'
    secondary.programme_activities.destroy_all
    puts "Secondary activities new total count #{secondary.programme_activities.count}"
  end
end
