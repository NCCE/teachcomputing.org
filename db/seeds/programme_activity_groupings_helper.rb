def maybe_attach_activity_to_grouping(grouping, activity_slug, order, legacy: false)
  if activity = Activity.find_by(slug: activity_slug)
    programme_activity = grouping.programme.programme_activities.find_or_create_by(activity_id: activity.id)
    programme_activity.update(programme_activity_grouping_id: grouping.id, order:, legacy:)
  end
end

def maybe_detach_activity_from_grouping(programme_activity_grouping, activity_slug)
  if activity = Activity.find_by(slug: activity_slug)
    programme_activity_grouping
      .programme
      .programme_activities
      .find_by(activity:, programme_activity_grouping:)
      &.destroy
  end
end
