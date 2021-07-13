namespace :split_primary_and_secondary_activites do
  task remove_programme_activities: :environment do
    activities = ['contribute-to-online-discussion', 'attend-a-cas-community-meeting',
                  'lead-a-cas-community-of-practice', 'lead-a-session-at-a-regional-or-national-conference']
    programme = Programme.secondary_certificate

    activities.each do |slug|
      activity = Activity.find_by(slug: slug)
      programme_activity = programme.programme_activities.find_by(activity_id: activity.id)
      programme_activity.delete
    end
  end

  task transfer_achievements: :environment do
    activities = ['contribute-to-online-discussion', 'attend-a-cas-community-meeting',
                  'lead-a-cas-community-of-practice', 'lead-a-session-at-a-regional-or-national-conference']
    secondary_certificate = Programme.secondary_certificate

    activities.each do |slug|
      activity = Activity.find_by(slug: slug)
      secondary_activity = Activity.find_by(slug: slug + '-secondary')
      next unless secondary_activity

      achievements = activity.achievements.where(programme_id: secondary_certificate.id)
      achievements.each do |achievement|
        achievement.update(activity_id: secondary_activity.id)
      end
    end
  end
end
