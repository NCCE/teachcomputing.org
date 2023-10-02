module DashboardHelper
  def get_date_string(achievement)
    if achievement.current_state == :complete.to_s
      "Completed on #{achievement.created_at.strftime('%b %Y')}"
    else
      "Enrolled on #{achievement.updated_at.strftime('%b %Y')}"
    end
  end

  def course_icon_class(activity)
    case activity.category.to_sym
    when :online
      'icon-online'
    else
      if activity.remote_delivered_cpd
        'icon-remote'
      else
        'icon-map-pin'
      end
    end
  end

  def stem_course_details(user_course_info, template_no)
    user_course_info&.find { |course| course.course_template_no == template_no }
  end

  def course_category(activity)
    if activity.remote_delivered_cpd
      'remote'
    else
      activity.category
    end
  end
end
