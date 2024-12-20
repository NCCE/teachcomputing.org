# frozen_string_literal: true

class Cms::StickyDashboardBarComponent < ViewComponent::Base
  delegate :current_user, to: :helpers

  def initialize(programme_slug:)
    @programme = Programme.find_by(slug: programme_slug)
  end

  def render?
    @programme.user_enrolled?(current_user)
  end
end
