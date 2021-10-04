class StateMachines::AchievementStateMachine
  include Statesman::Machine

  state :enrolled, initial: true
  state :in_progress
  state :complete
  state :dropped

  transition from: :enrolled, to: %i[in_progress complete dropped]
  transition from: :in_progress, to: %i[complete dropped]
  transition from: :dropped, to: %i[enrolled complete in_progress]

  after_transition(to: :complete) do |achievement, _transition|
    CompleteAchievementEmailJob.perform_later(achievement.user_id, achievement.activity_id) if
      [Activity::FACE_TO_FACE_CATEGORY, Activity::ONLINE_CATEGORY].include?(achievement.activity.category)
    IssueBadgeJob.set(wait: 2.minutes).perform_later(achievement.id)

    CheckNextStepsJob.set(wait: 2.days).perform_later(achievement.user_id)
  end
end
