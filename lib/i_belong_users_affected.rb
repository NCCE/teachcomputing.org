module IBelongUsersAffected
  # Users who have:
  #   Completed the CPD
  #   Downloaded the resources
  #   Completed an activity
  #   NOT completed implementation of TCC resources
  def self.completed_cpds_downloaded_resources_activity_completed_NO_tcc_resources
    programme = Programme.find_by(slug: 'i-belong')
  
    # First Programme Activity Grouping
    cpd_group = programme.programme_activity_groupings.find_by(sort_key: 2)
    cpd_activities = cpd_group.activities.select(:id)
  
    # Second Programme Activity Grouping
    second_group = programme.programme_activity_groupings.find_by(sort_key: 3)
    download_activity = second_group.activities.where(slug: 'download-and-use-the-i-belong-handbook').select(:id)
    tcc_activity = second_group.activities.where(slug: 'implement-selected-key-stage-3-teach-computing-curriculum-resources').select(:id)

    # Third Programme Activity Grouping
    third_group = programme.programme_activity_groupings.find_by(sort_key: 4)
    third_activities = third_group.activities.select(:id)

    users_from_achievements = Achievement
      .joins(user: :user_programme_enrolments)
      .where(user: {user_programme_enrolments: UserProgrammeEnrolment.where(programme: programme).in_state(:enrolled)})
      .in_state(:complete)
      .distinct
      .select(:user_id)

    User
      .where(id: users_from_achievements.where(activity_id: cpd_activities))
      .where(id: users_from_achievements.where(activity_id: download_activity))
      .where(id: users_from_achievements.where(activity_id: third_activities))
      .where.not(id: users_from_achievements.where(activity_id: tcc_activity))
      .distinct
      .pluck(:email)
  end
  

  # Users who have:
  #   Completed the CPD
  #   Downloaded the resources
  #   NOT completed an activity
  #   Completed implementation of TCC resources
  def self.completed_cpds_downloaded_resources_activity_NOT_completed_tcc_resources
    programme = Programme.find_by(slug: 'i-belong')
  
    # First Programme Activity Grouping
    cpd_group = programme.programme_activity_groupings.find_by(sort_key: 2)
    cpd_activities = cpd_group.activities.select(:id)
  
    # Second Programme Activity Grouping
    second_group = programme.programme_activity_groupings.find_by(sort_key: 3)
    download_activity = second_group.activities.where(slug: 'download-and-use-the-i-belong-handbook').select(:id)
    tcc_activity = second_group.activities.where(slug: 'implement-selected-key-stage-3-teach-computing-curriculum-resources').select(:id)
  
    # Third Programme Activity Grouping
    third_group = programme.programme_activity_groupings.find_by(sort_key: 4)
    third_activities = third_group.activities.select(:id)

    users_from_achievements = Achievement
      .joins(user: :user_programme_enrolments)
      .where(user: {user_programme_enrolments: UserProgrammeEnrolment.where(programme: programme).in_state(:enrolled)})
      .in_state(:complete)
      .distinct
      .select(:user_id)

    User
      .where(id: users_from_achievements.where(activity_id: cpd_activities))
      .where(id: users_from_achievements.where(activity_id: download_activity))
      .where(id: users_from_achievements.where(activity_id: tcc_activity))
      .where.not(id: users_from_achievements.where(activity_id: third_activities))
      .distinct
      .pluck(:email)
  end
end