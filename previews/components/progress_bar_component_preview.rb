class ProgressBarComponentPreview < ViewComponent::Preview
  def default
    render(
      ProgressBarComponent.new(
        programme: Programme.secondary_certificate
      )
    )
  end

  def primary
    render(
      ProgressBarComponent.new(
        programme: Programme.primary_certificate
      )
    )
  end
end
