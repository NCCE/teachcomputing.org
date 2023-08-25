class ProgrammeActivityGroupings::CreditCounted < ProgrammeActivityGrouping
  store_accessor :metadata, %i[required_credit_count]

  def user_complete?(user)
    user_achievement_activity_ids = achievements(user).pluck(:activity_id)

    completed_credit_count = programme_activities
      .select { _1.activity_id.in? user_achievement_activity_ids }
      .sum { _1.activity.credit || 0 }

    completed_credit_count >= required_credit_count
  end
end
