namespace :populate_missing_achievements do
  task complete: :environment do
    attempt_user_ids = AssessmentAttempt.in_state(:passed).pluck(:user_id)
    activity = Activity.find_by(slug: 'cs-accelerator-assessment')
    assessment = Assessment.find_by(class_marker_test_id: '1071279')
    achievement_user_ids = Achievement.in_state(:complete).where(activity_id: activity.id).pluck(:user_id)

    created_achievements = []

    attempt_user_ids.each do |user_id|
      user = User.find(user_id)
      next if achievement_user_ids.include?(user_id) do
        achievement = user.achievements.find_or_initialize_by(activity_id: activity.id)
        achievement.save
        certificate_number = assessment.assessment_counter.get_next_number
        achievement.set_to_complete(certificate_number: certificate_number)
        created_achievements << "#{achievement.id} - #{user.email}"
      end
    end

    puts created_achievements
  end

  task commenced: :environment do
    attempt_user_ids = AssessmentAttempt.in_state(:failed).pluck(:user_id)
    activity = Activity.find_by(slug: 'cs-accelerator-assessment')
    achievement_user_ids = Achievement.in_state(:commenced).where(activity_id: activity.id).pluck(:user_id)

    created_achievements = []

    attempt_user_ids.each do |user_id|
      user = User.find(user_id)
      unless if achievement_user_ids.include?(user_id) do
        achievement = user.achievements.find_or_initialize_by(activity_id: activity.id)
        achievement.save
        created_achievements << "#{achievement.id} - #{user.email}"
      end
    end

    puts created_achievements
  end
end
