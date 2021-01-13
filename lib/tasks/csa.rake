namespace :csa do
  desc 'Find all users who have started a CSA course but are not enrolled on the certificate and auto enrol them'
  task :auto_enrol, [:limit] => :environment do |_t, args|
    limit = args[:limit]

    csa = Programme.cs_accelerator

    # get list of all user ids enrolled on csa
    enrolled_user_ids = csa.user_programme_enrolments.pluck(:user_id)

    # get all achievements where the programme id matches csa and the user is
    # not enrolled
    csa_achievements = Achievement.where.not(user_id: enrolled_user_ids).where(programme_id: csa.id)

    csa_achievements = csa_achievements.limit(limit) if limit.present?

    user_achievements = Hash.new { |h, k| h[k] = [] }
    csa_achievements.each { |c| user_achievements[c.user_id] << c }

    user_achievements.each do |user_id, achievements|
      enrolled_user_ids << user_id
      CSAccelerator::AutoEnrolJob.perform_later(achievement_id: achievements.first.id)
    end

    abort('Reached limit') if limit.present?

    # get list of all achievements which are part of csa for unenrolled users
    # but where programme id is not set on achievement
    csa_achievements = Achievement.joins(activity: [:programme_activities])
                                  .where.not(user_id: enrolled_user_ids)
                                  .where(activity: { programme_activities: { programme_id: [csa.id] } })
    user_achievements = Hash.new { |h, k| h[k] = [] }
    csa_achievements.each { |c| user_achievements[c.user_id] << c }
    user_achievements.each do |user_id, achievements|
      enrolled_user_ids << user_id
      CSAccelerator::AutoEnrolJob.perform_later(achievement_id: achievements.first.id)
    end
  end
end
