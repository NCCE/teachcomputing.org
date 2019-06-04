module ActivitiesHelper
  def class_marker_diagnostic_url(user)
    ENV.fetch('CLASS_MARKER_DIAGNOSTIC_URL') + "&cm_e=#{user.email}&cm_user_id=#{user.id}"
  end
end
