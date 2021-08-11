namespace :achievements do
  desc 'TODO'
  task set_progress: :environment do
    achievements = Achievement.where(progress: 0)
    puts "Updating #{achievements.length} achievements"

    achievements.each do |achievement|
      print '.'
      prog = achievement.last_transition.metadata['progress']
      achievement.update(progress: prog.to_i) if prog.present?
    end

    puts ''
    puts 'Completed'
  end
end
