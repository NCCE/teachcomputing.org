module CertificateHelper
  def add_group_complete_icon_class(current_user, group)
    group.user_complete?(current_user) ? "ncce-activity-list__title--complete" : ""
  end

  def add_groups_complete_icon_class(current_user, groups)
    complete = groups.all? { |group| group.user_complete?(current_user) }
    complete ? "ncce-activity-list__title--complete" : ""
  end

  def sort_complete_first(activities:, complete: false)
    return activities unless complete

    activities.sort_by { |a| current_user.achievements.find_by(activity_id: a.activity_id)&.complete? ? 0 : 1 }
  end
end
