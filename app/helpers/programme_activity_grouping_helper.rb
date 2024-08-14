module ProgrammeActivityGroupingHelper
  def primary_completion_instruction(group)
    output = content_tag(:strong, "Complete at least #{group.required_for_completion.humanize} activity")
    output << " to "
    output << if group.web_copy_completion_instruction.present?
      group.web_copy_completion_instruction.downcase
    else
      group.title.downcase
    end

    output.html_safe
  end

  def i_belong_completion_instruction(group)
    output = group.title.dup

    completable_activity_count = group.programme_activities.includes(:activity).where(activity: {coming_soon: false}).count

    if group.required_for_completion != completable_activity_count
      output << " by completing "
      output << content_tag(:strong, "at least #{group.required_for_completion.humanize}")
      output << " "
      output << "activity".pluralize(group.required_for_completion)
    end

    output.html_safe
  end
end
