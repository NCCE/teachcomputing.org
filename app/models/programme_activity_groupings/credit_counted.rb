class ProgrammeActivityGroupings::CreditCounted < ProgrammeActivityGrouping
  store_accessor :metadata, %i[required_credit_count]

  # credit counted
  def users_completed(users:)
    users_achievement_activity_ids = fetch_users_achievement_activity_ids(users:)

    activities = programme_activities.includes(:activity).map(&:activity)

    users.map do |user|
      completed_credit_count = activities
        .select { _1.id.in?(users_achievement_activity_ids[user.id] || []) }
        .sum { _1.credit || 0 }

      [user.id, completed_credit_count >= required_credit_count]
    end.to_h
  end

  def course_status_class(current_user, state: [:enrolled, :in_progress])
    completed_achievements = current_user.achievements
      .with_courses
      .in_state(*state)
      .belonging_to_programme(programme)
      .joins(:activity)

    total_credits = completed_achievements.sum("activities.credit")

    if total_credits >= required_credit_count
      "icon-ticked-circle"
    elsif completed_achievements.any?
      "icon-pending-circle"
    else
      "icon-blank-circle"
    end
  end
end
