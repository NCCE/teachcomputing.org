module InactivityQueries
  def self.no_activities_completed_type(slug)
    "#{slug}-inactivity-none-completed"
  end

  def self.i_belong_only_one_section_completed_type
    "i-belong-inactivity-only-completed-one-section"
  end

  def self.i_belong_all_but_understanding_factors_type
    "i-belong-inactivity-all-but-understanding-factors"
  end

  def self.i_belong_all_but_access_resources_type
    "i-belong-inactivity-all-but-understanding-factors"
  end

  def self.i_belong_all_but_increase_engagement_type
    "i-belong-inactivity-all-but-increase-engagement"
  end

  def self.completed_cpds_but_no_community_activities_type(slug)
    "#{slug}-completed-cpds-but-no-community-activities"
  end

  def self.no_activities_completed(certificate)
    users_already_sent = User.joins(:sent_emails).where(sent_emails: {mailer_type: no_activities_completed_type(certificate.slug)})

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

    users_already_sent = User.joins(:sent_emails).where(sent_emails: {mailer_type: i_belong_only_one_section_completed_type})

    # Is one objective completed but the others not yet?
    objective_1_completed = "sum((achievements.activity_id in (:objective_1))::int) >= 1 and sum((achievements.activity_id in (:objective_2))::int) < 3 and sum((achievements.activity_id in (:objective_3))::int) = 0"
    objective_2_completed = "sum((achievements.activity_id in (:objective_2))::int) >= 3 and sum((achievements.activity_id in (:objective_1))::int) = 0 and sum((achievements.activity_id in (:objective_3))::int) = 0"
    objective_3_completed = "sum((achievements.activity_id in (:objective_3))::int) >= 1 and sum((achievements.activity_id in (:objective_2))::int) < 3 and sum((achievements.activity_id in (:objective_1))::int) = 0"

    every_achievement_is_old = "every(achievements.updated_at < :old_age)"

    user_achievements = Achievement
      .joins(user: :user_programme_enrolments)
      .where.not(user: users_already_sent)
      .where(
        user: {user_programme_enrolments: UserProgrammeEnrolment.where(programme: i_belong).in_state(:enrolled)},
        activity: objective_1 + objective_2 + objective_3
      )
      .group(:user_id)
      .having("((#{objective_1_completed}) or (#{objective_2_completed}) or (#{objective_3_completed})) and #{every_achievement_is_old}", objective_1:, objective_2:, objective_3:, old_age: 1.month.ago)
      .count

    User.where(id: user_achievements.keys)
  end

  def self.i_belong_completed_appart_from_understand_factors
    i_belong = Programme.i_belong

    objective_1 = i_belong.programme_objectives.first.activities.pluck(:id) # Understand factors
    objective_2 = i_belong.programme_objectives.second.activities.pluck(:id) # Access resources
    objective_3 = i_belong.programme_objectives.third.activities.pluck(:id) # Increase engagement

    users_already_sent = User.joins(:sent_emails).where(sent_emails: {mailer_type: i_belong_only_one_section_completed_type})

    user_achievements = Achievement
      .joins(user: :user_programme_enrolments)
      .where.not(user: users_already_sent)
      .where(
        user: {user_programme_enrolments: UserProgrammeEnrolment.where(programme: i_belong).in_state(:enrolled)},
        activity: objective_1 + objective_2 + objective_3
      )
      .group(:user_id)
      .having("every(achievements.updated_at < :old_age and achievements.id not in (:objective_1)) and sum((achievements.id in (:objective_2))::int) >= 3 and sum((achievements.id in (:objective_3))::int) >= 1", objective_1:, objective_2:, objective_3:, old_age: 1.month.ago)
      .count

    User.where(id: user_achievements.keys)
  end

  def self.i_belong_completed_appart_from_access_resources
    i_belong = Programme.i_belong

    objective_1 = i_belong.programme_objectives.first.activities.pluck(:id) # Understand factors
    objective_2 = i_belong.programme_objectives.second.activities.pluck(:id) # Access resources
    objective_3 = i_belong.programme_objectives.third.activities.pluck(:id) # Increase engagement

    users_already_sent = User.joins(:sent_emails).where(sent_emails: {mailer_type: i_belong_only_one_section_completed_type})

    user_achievements = Achievement
      .joins(user: :user_programme_enrolments)
      .where.not(user: users_already_sent)
      .where(
        user: {user_programme_enrolments: UserProgrammeEnrolment.where(programme: i_belong).in_state(:enrolled)},
        activity: objective_1 + objective_2 + objective_3
      )
      .group(:user_id)
      .having("every(achievements.updated_at < :old_age and achievements.id not in (:objective_2)) and sum((achievements.id in (:objective_1))::int) >= 1 and sum((achievements.id in (:objective_3))::int) >= 1", objective_1:, objective_2:, objective_3:, old_age: 1.month.ago)
      .count

    User.where(id: user_achievements.keys)
  end

  def self.i_belong_completed_appart_from_increase_engagement
    i_belong = Programme.i_belong

    objective_1 = i_belong.programme_objectives.first.activities.pluck(:id) # Understand factors
    objective_2 = i_belong.programme_objectives.second.activities.pluck(:id) # Access resources
    objective_3 = i_belong.programme_objectives.third.activities.pluck(:id) # Increase engagement

    users_already_sent = User.joins(:sent_emails).where(sent_emails: {mailer_type: i_belong_only_one_section_completed_type})

    user_achievements = Achievement
      .joins(user: :user_programme_enrolments)
      .where.not(user: users_already_sent)
      .where(
        user: {user_programme_enrolments: UserProgrammeEnrolment.where(programme: i_belong).in_state(:enrolled)},
        activity: objective_1 + objective_2 + objective_3
      )
      .group(:user_id)
      .having("every(achievements.updated_at < :old_age and achievements.id not in (:objective_3)) and sum((achievements.id in (:objective_1))::int) >= 1 and sum((achievements.id in (:objective_2))::int) >= 3", objective_1:, objective_2:, objective_3:, old_age: 1.month.ago)
      .count

    User.where(id: user_achievements.keys)
  end

  def self.completed_cpds_but_no_community_activities(certificate)
    cpd_activities = certificate.programme_objectives.first.activities
    community_activities = certificate.programme_objectives[1..].flat_map(&:activities)

    users_already_sent = User.joins(:sent_emails).where(sent_emails: {mailer_type: completed_cpds_but_no_community_activities_type(certificate.slug)})

    # User has not completed any community activities, and all their CPD
    # activities are older than 1 month
    user_achievements = Achievement
      .joins(user: :user_programme_enrolments)
      .where.not(user: users_already_sent)
      .where(
        user: {user_programme_enrolments: UserProgrammeEnrolment.where(programme: certificate).in_state(:enrolled)},
        activity: cpd_activities + community_activities
      )
      .group(:user_id)
      .having("every(achievements.activity_id not in (?) and achievements.updated_at < ?)", community_activities, 3.months.ago)
      .count

    User.where(id: user_achievements.keys)
  end
end
