def maybe_attach_activity_to_pathway(pathway, slug: nil, stem_activity_code: nil)
  activity =
    if slug.present?
      Activity.find_by(slug:)
    else
      Activity.find_by(stem_activity_code:)
    end

  unless activity
    puts "OI! #{slug}#{stem_activity_code} doesn't exist"
  end

  pathway.pathway_activities.find_or_create_by(activity_id: activity.id) if activity && !pathway.pathway_activities.include?(activity)
end

def maybe_detach_activity_from_pathway(pathway, slug: nil, stem_activity_code: nil, stem_course_template_no: nil)
  activity =
    if slug.present?
      Activity.find_by(slug:)
    elsif stem_activity_code.present?
      Activity.find_by(stem_activity_code:)
    else
      Activity.find_by(stem_course_template_no:)
    end

  pathway.pathway_activities.find_by(activity:)&.destroy
end
