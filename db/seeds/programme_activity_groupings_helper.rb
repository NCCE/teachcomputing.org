def maybe_attach_activity_to_grouping(grouping, activity_slug, order)
  if activity = Activity.find_by(slug: activity_slug)
    programme_activity = grouping.programme.programme_activities.find_or_create_by(activity_id: activity.id)
    programme_activity.update(programme_activity_grouping_id: grouping.id, order:)
  end
end
