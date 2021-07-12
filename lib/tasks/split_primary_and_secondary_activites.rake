namespace :split_primary_and_secondary_activites do
  task remove_activity_groupings: :environment do
    activities = ['contribute-to-online-discussion', 'attend-a-cas-community-meeting',
                  'lead-a-cas-community-of-practice', 'lead-a-session-at-a-regional-or-national-conference']
    programme = Programme.secondary_certificate

    activities.each do |slug|
      activity = Activity.find_by(slug: slug)
      programme_activity = programme.programme_activities.find_by(activity_id: activity.id)
      programme_activity.delete
    end
  end

  task remove_programme_activities: :environment do
    activities = ['contribute-to-online-discussion', 'attend-a-cas-community-meeting',
                  'lead-a-cas-community-of-practice', 'lead-a-session-at-a-regional-or-national-conference']
    programme = Programme.secondary_certificate

    activities.each do |slug|
      activity = Activity.find_by(slug: slug)
      programme_activity_grouping = programme.programme_activity_groupings.find_by(activity_id: activity.id)
      programme_activity_grouping.delete
    end
  end

  task transfer_achievements: :environment do
    activities = ['contribute-to-online-discussion', 'attend-a-cas-community-meeting',
                  'lead-a-cas-community-of-practice', 'lead-a-session-at-a-regional-or-national-conference']
    primary_certificate = Programme.primary_certificate

    activities.each do |_primary_activity|
      secondary_activity = Activity.find_by(slug: primary_certificate.slug + '-secondary')
      next unless secondary_activity

      achievements = activity.achievements.where(programme_id: secondary_certificate.id)
      achievements.each do |achievement|
        achievement.update(activity_id: secondary_activity.id)
      end
    end
  end
end
