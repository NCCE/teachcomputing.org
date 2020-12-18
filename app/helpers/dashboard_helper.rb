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

  def get_course_suffix(achievement)
    get_course_strings(achievement)&.parameterize
  end

  def get_date_string(achievement)
    if achievement.current_state == :complete.to_s
      "Completed on #{achievement.created_at.strftime("%b %Y")}"
    else
      "Enrolled on #{achievement.updated_at.strftime("%b %Y")}"
    end
  end
end
