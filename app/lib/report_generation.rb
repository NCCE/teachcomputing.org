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
        cpd_index = programme.secondary_certificate? ? 1 : 0

        users_completed_cpd_component =
          programme
            .programme_objectives[cpd_index]
            &.users_completed(users:)

        users_completed_first_community_component =
          programme
            .programme_objectives[cpd_index + 1]
            &.users_completed(users:)

        users_completed_second_community_component =
          programme
            .programme_objectives[cpd_index + 2]
            &.users_completed(users:)

        users_completed_programme = UserProgrammeEnrolment
          .in_state(:complete)
          .where(user: users, programme:)
          .pluck(:user_id)

        users_pending_programme = UserProgrammeEnrolment
          .in_state(:pending)
          .where(user: users, programme:)
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
            completed_first_community_component: users_completed_first_community_component&.dig(user.id) || false,
            completed_second_community_component: users_completed_second_community_component&.dig(user.id) || false,
            completed_certificate: user.id.in?(users_completed_programme),
            pending_certificate: user.id.in?(users_pending_programme),
            created_at: now,
            updated_at: now
          }
        end
      end

      UserReportEntry.insert_all(records)
    end
  end
end
