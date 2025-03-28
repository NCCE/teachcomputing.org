module CertificateHelper
  def add_group_complete_icon_class(current_user, group)
    group.user_complete?(current_user) ? "ncce-activity-list__title--complete" : ""
  end

  def add_groups_complete_icon_class(current_user, groups)
    complete = groups.all? { |group| group.user_complete?(current_user) }
    complete ? "ncce-activity-list__title--complete" : ""
  end
end
