module Programmes
  class ProgressQuery
    def initialize(programme, active_state, enrolled, completed_groups = [])
      @programme = programme
      @active_state = active_state # :active, :lapsing, :lapsed
      @enrolled = enrolled
      @completed_groups = completed_groups
    end

    def call
      query = if @enrolled
        User.joins(:user_programme_enrolments, achievements: {activity: :programme_activities})
          .where(
            user_programme_enrolments: {programme: @programme},
            programme_activities: {programme: @programme, legacy: false},
            achievements: {updated_at: dates_by_state}
          )
      else
        User.joins(:user_programme_enrolments, achievements: {activity: :programme_activities})
          .where(
            programme_activities: {programme: @programme, legacy: false},
            achievements: {updated_at: dates_by_state}
          )
          .where.not(
            id: UserProgrammeEnrolment.select(:user_id).where(programme: @programme)
          )
      end
      if @completed_groups.any?
        query = query.group(:id)
        @completed_groups.each do |group|
          query = if group.instance_of? ProgrammeActivityGroupings::CreditCounted
            query.having("SUM(CASE WHEN \"programme_activities\".\"programme_activity_grouping_id\" = ? THEN activities.credit END) >= ?", group.id, group.metadata["required_credit_count"])
          else
            query.having("COUNT(CASE WHEN \"programme_activities\".\"programme_activity_grouping_id\" = ? THEN 1 END) >= ?", group.id, group.required_for_completion)
          end
        end
      end
      query.distinct
    end

    def dates_by_state
      case @active_state
      when :active
        DateTime.now.months_ago(4)..DateTime.now
      when :lapsing
        DateTime.now.months_ago(8)..DateTime.now.months_ago(4)
      when :lapsed
        DateTime.now.months_ago(1000)..DateTime.now.months_ago(8)
      else
        DateTime.now.months_ago(4)..DateTime.now
      end
    end
  end
end
