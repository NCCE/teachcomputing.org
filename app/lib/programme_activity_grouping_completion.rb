# The idea of this module is to provide a way to calculate this information in bulk so it can be used in reports safely
module ProgrammeActivityGroupingCompletion
  def self.users_completed_credit_counted(
    programme_activity_grouping:,
    users:
  )
    users_achievement_activity_ids = fetch_users_achievement_activity_ids(
      programme_activity_grouping:,
      users:
    )

    activities = programme_activity_grouping.programme_activities.includes(:activity).map(&:activity)

    users.map do |user|
      completed_credit_count = activities
        .select { _1.id.in?(users_achievement_activity_ids[user.id] || []) }
        .sum { _1.credit || 0 }

      [user.id, completed_credit_count >= programme_activity_grouping.required_credit_count]
    end.to_h
  end

  def self.users_completed_completion_counted(
    programme_activity_grouping:,
    users:
  )
    users_achievement_activity_ids = fetch_users_achievement_activity_ids(
      programme_activity_grouping:,
      users:
    )

    activities = programme_activity_grouping.programme_activities.includes(:activity).map(&:activity)

    users.map do |user|
      completed_activity_count = activities
        .count { _1.id.in?(users_achievement_activity_ids[user.id] || []) }

      [user.id, completed_activity_count >= programme_activity_grouping.required_for_completion]
    end.to_h
  end

  private_class_method def self.fetch_users_achievement_activity_ids(programme_activity_grouping:, users:)
    Achievement
      .in_state(:complete)
      .belonging_to_programme(programme_activity_grouping.programme)
      .joins(activity: :programme_activities)
      .where(
        activities: {programme_activities: {legacy: false}},
        user: users
      )
      .group_by(&:user_id)
      .transform_values { _1.map(&:activity_id) }
  end
end
