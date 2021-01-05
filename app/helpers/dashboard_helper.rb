module DashboardHelper
  def get_course_strings(achievement)
    if achievement&.cs_accelerator?
      'CS Accelerator'
    elsif achievement&.secondary_certificate?
      'Secondary'
    elsif achievement&.primary_certificate?
      'Primary'
    end
  end

  def get_course_tag_class(achievement)
    "dashboard-tags--#{get_course_strings(achievement)&.parameterize}"
  end

  def get_date_string(achievement)
    if achievement.current_state == :complete.to_s
      "Completed #{achievement.created_at.strftime("%b %Y")}"
    else
      "Enrolled #{achievement.updated_at.strftime("%b %Y")}"
    end
  end
end
