class FeedbackComponentPreview < ViewComponent::Preview
  def default
    render(FeedbackComponent.new(heading: "What can we do better?", area: :a_level_subject_knowledge_certificate))
  end
end
