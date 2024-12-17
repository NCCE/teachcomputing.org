class CommunityEvidenceSubmissionModalComponent < ViewComponent::Base
  def initialize(activity:, achievement: nil, button_class: nil)
    @activity = activity
    @achievement = achievement
    @button_class = button_class
  end

  def render?
    !@achievement&.community_achievement_complete?
  end

  def reopen_button_text
    return "Add more evidence" if @achievement&.rejected?
    @achievement&.evidence.present? ? "Continue editing" : "Submit evidence"
  end

  def check_submission_option slug
    return false unless @achievement

    return @achievement.submission_option == slug unless @achievement.submission_option.blank?
    default_option = @activity.public_copy_submission_options.find { _1["default"] }

    return default_option["slug"] == slug if default_option
    false
  end

  def minimum_character_requirement
    @activity.programmes.collect(&:minimum_character_required_community_evidence).max
  end
end
