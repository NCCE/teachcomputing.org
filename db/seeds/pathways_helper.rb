def maybe_attach_activity_to_pathway(pathway, activity_slug)
  activity = Activity.find_by(slug: activity_slug)
  pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)
end
