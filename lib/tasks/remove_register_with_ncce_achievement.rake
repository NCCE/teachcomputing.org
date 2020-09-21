task remove_register_with_ncce_achievement: :environment do
  activity = Activity.find_by(slug: 'registered-with-the-national-centre')
  achievements = activity.achievements
  puts "Total achievements #{achievements.count}"
  puts "Deleting achievements"
  achievements.destroy_all
  activity.delete
end
