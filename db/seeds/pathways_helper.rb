def maybe_attach_activity_to_pathway(pathway, slug: nil, stem_activity_code: nil)
  activity =
    if slug.present?
      Activity.find_by(slug:)
    else
      Activity.find_by(stem_activity_code:)
    end

  pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)
end
