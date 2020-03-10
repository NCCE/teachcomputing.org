namespace :achievements do
  desc 'Update online Achievements to rename the "commenced" state to "enrolled"'
  task migrate_to_new_state: :environment do
    achievements = Achievement.in_state('commenced')
    puts "Going to update #{achievements.count} achievements"

    ActiveRecord::Base.transaction do
      achievements.each do |achievement|
        achievement.last_transition&.update(to_state: 'enrolled')
        print '.'
      end
    end

    puts ' Done - please run an import of FL users'
  end

  task add_programme_id: :environment do
    achievements = Achievement.all
    puts "Going to update #{achievements.count} achievements, one '.' means 100"

    ActiveRecord::Base.transaction do
      achievements.each_with_index do |achievement, index|
        next unless achievement.programme_id.nil?

        achievement.send(:fill_in_programme_id)
        achievement.save

        print '.' if (index % 100).zero?
      end
    end

    puts ' Done'
  end
end
