class SendInactivityEmailsJob < ApplicationJob
  def perform

  end

  def i_belong_none_completed
    i_belong = Programme.i_belong

    users_already_sent = User.joins(:sent_emails).where(sent_emails: { mailer_type: "i-belong-inactivity-none-completed" })

    users = User.where(
      user_programme_enrolments: UserProgrammeEnrolment
        .where(programme: i_belong, created_at: ..1.month.ago)
        .where("(SELECT count(*) FROM activities WHERE user_id = user_programme_enrolments.id) = 0")
        .where.not(user: users_already_sent)
    )

    users.each do |user|
      # Send email
    end
  end

  def i_belong_only_completed_one_section
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

    users = User.find_by(id: user_achievements.keys)

    users.each do |user|
      # send email
    end
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

    users = User.find_by(id: user_achievements.keys)

    users.each do |user|
      # send email
    end
  end

  def primary_or_secondary(certificate)
    # This is an N+1, but its of three items so I'm not convinced anything
    # fancier is worth implementing
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

    users = User.find_by(id: user_achievements.keys)

    users.each do |user|
      # send email
    end
  end
end
