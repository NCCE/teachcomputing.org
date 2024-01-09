module ActivitiesHelper
  def class_marker_diagnostic_url(user)
    ENV.fetch("CLASS_MARKER_DIAGNOSTIC_URL") + "&cm_e=#{user.email}&cm_user_id=#{user.id}"
  end

  def activity_type(activity)
    return "Online" if activity.online?
    return "Remote" if activity.remote_delivered_cpd?

    "Face to face"
  end

  def activity_icon_class(activity)
    return "icon-online" if activity.online?
    return "icon-remote" if activity.remote_delivered_cpd?

    "icon-map-pin"
  end
end
