class DashBadgeComponentPreview < ViewComponent::Preview
  def unfixed_width
    badge = Credly::Badge.by_programme_badge_template_ids(nil, nil, preview: true)

    render(DashBadgeComponent.new(badge:))
  end

  def fixed_width
    badge = Credly::Badge.by_programme_badge_template_ids(nil, nil, preview: true)

    render(DashBadgeComponent.new(badge:, fixed_width: true))
  end
end
