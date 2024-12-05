class CommunityEvidenceSubmissionModalComponent < ViewComponent::Base
  def initialize(activity:, achievement: nil, button_class: nil)
    @activity = activity
    @achievement = achievement
    @button_class = button_class
  end

  def achievement_complete?
    return unless @achievement

    return false if @activity.public_copy_submission_options
    @achievement.in_state?(:complete)
  end

  def achievement_rejected?
    return unless @achievement

    @achievement.in_state? :rejected
  end

  def reopen_button_text
    return "Add more evidence" if achievement_rejected?
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

  def default_evidence_submission_text
    "Encourage young people to develop important life skills through enrichment and engage with the wider community in practical, enjoyable, and meaningful ways"
  end
end
