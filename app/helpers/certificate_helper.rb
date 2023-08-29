module CertificateHelper
  def add_group_complete_icon_class(current_user, group)
    group.user_complete?(current_user) ? 'ncce-activity-list__title--complete' : ''
  end

  def add_groups_complete_icon_class(current_user, groups)
    complete = groups.all? { |group| group.user_complete?(current_user) }
    complete ? 'ncce-activity-list__title--complete' : ''
  end

  def split_community_pathway_activities_by_visibility(group:, pathway_activities: nil)
    hidden_activities = nil
    group_activities = group.programme_activities

    if pathway_activities.present? && group_activities.present?
      pathway_activity_ids = pathway_activities.pluck(:activity_id)
      visible_activities = group_activities.includes(:activity).select do |group_activity|
        pathway_activity_ids.include?(group_activity.activity.id)
      end
      hidden_activities = group_activities - visible_activities
    else
      visible_activities = group_activities
    end

    {
      visible_activities: sort_complete_first(
        activities: visible_activities,
        complete: group.user_complete?(current_user)
      ),
      hidden_activities:
    }
  end

  def sort_complete_first(activities:, complete: false)
    return activities unless complete

    activities.sort_by { |a| current_user.achievements.find_by(activity_id: a.activity_id)&.complete? ? 0 : 1 }
  end

  def format_activity_title(group)
    words = group.title.split

    output = String.new
    output << content_tag(:strong, words.first)
    output << ' '
    output << words[1..].join(' ')

    if group.required_for_completion != group.programme_activities.size
      output << ' by completing '
      output << content_tag(:strong, "at least #{group.required_for_completion.humanize}")
      output << ' '
      output << 'activity'.pluralize(group.required_for_completion)
    end

    output.html_safe
  end
end
