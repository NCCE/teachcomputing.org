module InactivityQueries
  def self.no_activities_completed_type(slug)
    "#{slug}-inactivity-none-completed"
  end

  def self.no_activities_completed(certificate)
    users_already_sent = User.joins(:sent_emails).where(sent_emails: { mailer_type: no_activities_completed_type(certificate.slug) })

    User.where(
      user_programme_enrolments: UserProgrammeEnrolment
        .where(programme: certificate, created_at: ..1.month.ago)
        .where('(SELECT COUNT(*) FROM "achievements" INNER JOIN "activities" ON "activities"."id" = "achievements"."activity_id" INNER JOIN "programme_activities" ON "programme_activities"."activity_id" = "activities"."id" WHERE "programme_activities"."programme_id" = :programme_id AND "achievements"."user_id" = "user_programme_enrolments"."user_id") = 0', programme_id: certificate.id)
    ).where.not(id: users_already_sent)
  end

  def self.i_belong_only_one_section_completed
    i_belong = Programme.i_belong

    objective_1 = i_belong.programme_objectives.first.activities.pluck(:id)
    objective_2 = i_belong.programme_objectives.second.activities.pluck(:id) # Required for completion == 3
    objective_3 = i_belong.programme_objectives.third.activities.pluck(:id)

    users_already_sent = User.joins(:sent_emails).where(sent_emails: { mailer_type: "i-belong-inactivity-only-completed-one-section" })

    # Is one objective completed but the others not yet?
    objective_1_completed = "sum((achievements.activity_id in (:objective_1))::int) >= 1 and sum((achievements.activity_id in (:objective_2))::int) < 3 and sum((achievements.activity_id in (:objective_3))::int) = 0"
    objective_2_completed = "sum((achievements.activity_id in (:objective_2))::int) >= 3 and sum((achievements.activity_id in (:objective_1))::int) = 0 and sum((achievements.activity_id in (:objective_3))::int) = 0"
    objective_3_completed = "sum((achievements.activity_id in (:objective_3))::int) >= 1 and sum((achievements.activity_id in (:objective_2))::int) < 3 and sum((achievements.activity_id in (:objective_1))::int) = 0"

    every_achievement_is_old = "every(achievement.updated_at < :old_age)"

    user_achievements = Achievement
      .joins(user: :user_programme_enrolments)
      .where.not(user: users_already_sent)
      .where(
        user: { user_programme_enrolments: { programme: i_belong } },
        activity: objective_1 + objective_2 + objective_3
      )
      .where(user: { user_programme_enrolments: UserProgrammeEnrolment.where(programme: i_belong).in_state(:enrolled) })
      .group(:user_id)
        .having("((#{objective_1_completed}) or (#{objective_2_completed}) or (#{objective_3_completed})) and #{every_achievement_is_old}", objective_1:, objective_2:, objective_3:, old_age: 1.month.ago)
      .count

    User.find_by(id: user_achievements.keys)
  end

  def i_belong_completed_x_appart_from
    i_belong = Programme.i_belong

    activities = certificate.programme_objectives.second.activities

    users_already_sent = User.joins(:sent_emails).where(sent_emails: { mailer_type: "i-belong-inactivity-completed-x-appart-from" })

    user_achievements = Achievement
      .joins(user: :user_programme_enrolments)
      .where.not(user: users_already_sent)
      .where(
        user: { user_programme_enrolments: { programme: i_belong } },
        activity: activities
      )
      .where(user: { user_programme_enrolments: UserProgrammeEnrolment.where(programme: i_belong).in_state(:enrolled) })
      .group(:user_id)
      .having("count(*) == 2")
      .count

    User.find_by(id: user_achievements.keys)
  end

  def primary_or_secondary(certificate)
    cpd_activities = certificate.programme_objectives.first.activities
    community_activities = certificate.programme_objectives[1..].flat_map(&:activities)

    users_already_sent = User.joins(:sent_emails).where(sent_emails: { mailer_type: "#{certificate.slug}-inactivity" })

    # User has not completed any community activities, and all their CPD
    # activities are older than 1 month
    user_achievements = Achievement
      .joins(user: :user_programme_enrolments)
      .where.not(user: users_already_sent)
      .where(
        user: { user_programme_enrolments: { programme: certificate } },
        activity: cpd_activities + community_activities
      )
      .where(user: { user_programme_enrolments: UserProgrammeEnrolment.where(programme: certificate).in_state(:enrolled) })
      .group(:user_id)
      .having("every(achievements.activity_id not in (?) and achievements.updated_at < ?)", community_activities, 3.months.ago)
      .count

    User.find_by(id: user_achievements.keys)
  end
end
