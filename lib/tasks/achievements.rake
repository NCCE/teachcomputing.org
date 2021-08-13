namespace :achievements do
  desc 'Set progress on achievements where it is currently 0, takes value from transition meatadata where it exists'
  task set_progress: :environment do
    achievements = Achievement.where(progress: 0)
    puts "Updating #{achievements.length} achievements"

    achievements.each do |achievement|
      print '.'
      transition = achievement.last_transition
      next unless transition
      progress = transition.metadata['progress']
      achievement.update(progress: progress.to_i) if progress.present?
    end

    puts ''
    puts 'Completed'
  end
end
