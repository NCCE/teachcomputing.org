namespace :achievements do
  desc 'Set progress on achievements where it is currently 0, takes value from transition meatadata where it exists'
  task set_progress: :environment do
    achievements = Achievement.includes(:activity).where(progress: 0, activity: { provider: 'future-learn' })
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

  # TODO: delete this task after it has been run
  desc 'A one-off task to drop everyone from uncompleted future-learn courses. Run this once after the completion deadline has passed, that is after 31 March 2023'
  task drop_all_from_future_learn: :environment do
    # ignore any that are already dropped or complete.
    # newly enrolled achievements don't have an achievement_transition
    enrolled_achievements =
      Achievement
      .distinct
      .joins(:activity)
      .where('activities.provider': 'future-learn')
      .in_state(:enrolled, :in_progress)

    progress = 0
    total = enrolled_achievements.length
    start_message = "#{$0}: Starting. Dropping #{total} open FutureLearn enrollments"
    puts start_message
    Rails.logger.info start_message
    enrolled_achievements.each do |achievement|
      print '.'
      success = achievement.transition_to :dropped
      if success
        progress += 1
        next
      end
      puts "** Failed to drop achievement id: #{achievement.id} from #{achievement.activity.stem_activity_code}"
    end

    puts
    end_message = "#{$0}: Done. Dropped #{progress} out of #{total} open FutureLearn enrollments"
    puts end_message
    Rails.logger.info end_message
 end
end
