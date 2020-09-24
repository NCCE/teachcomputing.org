namespace :achievements do
  task add_programme_id: :environment do
    achievements = Achievement.where(programme_id: nil)
    puts "Going to update #{achievements.count} achievements, one '.' means 100"

    ActiveRecord::Base.transaction do
      achievements.each_with_index do |achievement, index|

        achievement.send(:fill_in_programme_id)
        achievement.save

        print '.' if (index % 100).zero?
      end
    end

    puts ' Done'
  end
end
