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
end
