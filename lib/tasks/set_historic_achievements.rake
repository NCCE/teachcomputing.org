namespace :set_historic_achievement do
  task registered_with_ncce: :environment do
    register_activity = Activity.registered_with_the_national_centre
    User.all.each do |user|
      Achievement.find_or_create_by!(user_id: user.id, activity_id: register_activity.id) do |achievement|
        achievement.user_id = user.id
        achievement.activity_id = register_activity.id
        achievement.created_at  = user.created_at
      end
    end
  end

  task set_state_to_complete_for_existing_achievements: :environment do
    achievements = Achievement.in_state(:commenced)
    puts "Total Achievements: #{achievements.count}"

    @achievements.each do |achievement|
      achievement.transition_to(:complete, credit: achievement.activity.credit)
      puts "Achievement: #{achievement.id} state: #{achievement.current_state}"
    end
  end
end
