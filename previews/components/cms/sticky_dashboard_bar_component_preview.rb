# frozen_string_literal: true

class Cms::StickyDashboardBarComponentPreview < ViewComponent::Preview
  def default
    render(Cms::StickyDashboardBarComponent.new(programme_slug: "programme_slug"))
  end
end
