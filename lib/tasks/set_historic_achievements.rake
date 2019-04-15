namespace :set_historic_achievement do
  task registered_with_ncce: :environment do
    register_activity = Activity.registered_with_the_national_centre
    User.all.each do |user|
      Achievement.find_or_create_by(user_id: user.id, activity_id: register_activity.id) do |achievement|
        achievement.user_id = user.id,
                              achievement.activity_id = register_activity.id,
                              achievement.created_at  = user.created_at
      end
    end
  end
end
