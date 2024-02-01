class ProgrammeActivityGroupings::CreditCounted < ProgrammeActivityGrouping
  store_accessor :metadata, %i[required_credit_count]

  def user_complete?(user)
    ProgrammeActivityGroupingCompletion.users_completed_credit_counted(
      programme_activity_grouping: self,
      users: [user]
    ).values.first
  end
end
