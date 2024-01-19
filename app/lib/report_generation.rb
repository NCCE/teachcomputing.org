module ReportGeneration
  def self.programmes
    [
      Programme.primary_certificate,
      Programme.secondary_certificate,
      Programme.i_belong
    ]
  end

  def self.generate_user_report
    UserReportEntry.delete_all

    User.in_batches do |users|
      records = []

      now = DateTime.now

      user_programme_enrolments = UserProgrammeEnrolment
        .where(user: users)
        .group_by(&:user_id)

      programmes.each do |programme|
        if programme.primary_certificate?
          users_completed_cpd_component = ProgrammeActivityGroupingCompletion.users_completed_credit_counted(
            programme_activity_grouping: programme.programme_objectives.first,
            users:
          )
        end

        if programme.secondary_certificate?
          users_completed_cpd_component = ProgrammeActivityGroupingCompletion.users_completed_credit_counted(
            programme_activity_grouping: programme.programme_objectives.second,
            users:
          )
        end

        users_completed_programme = UserProgrammeEnrolment
          .in_state(:complete)
          .where(user: users)
          .pluck(:user_id)

        users_achievements = Achievement
          .belonging_to_programme(programme)
          .where(user: users)
          .group_by(&:user_id)

        users.each do |user|
          user_programme_enrolment = user_programme_enrolments[user.id]
            &.find { _1.programme_id == programme.id }

          achievements = users_achievements[user.id]

          last_achievement =
            if achievements.present?
              # I'm not sure why, but calling .max(&:updated_at) was giving an argument rror
              achievements.max { _1.updated_at }
            end

          records << {
            programme_slug: programme.slug,
            user_email: user.email,
            user_stem_user_id: user.stem_user_id,
            user_enrolled: user_programme_enrolment.present?,
            enrolled_at: user_programme_enrolment&.created_at,
            last_active_at: last_achievement&.updated_at,
            completed_cpd_component: users_completed_cpd_component&.dig(user.id) || false,
            completed_certificate: user.id.in?(users_completed_programme),
            created_at: now,
            updated_at: now
          }
        end
      end

      UserReportEntry.insert_all(records)
    end
  end
end
