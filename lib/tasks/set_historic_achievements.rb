namespace :set_historic_achievement do
  task registered_with_ncce: :environment do
    User.all.each do |user|
      Achievement.create(user_id: user.id,
                         activity_id: Activity.registered_with_the_national_centre.id)
    end
  end
end
