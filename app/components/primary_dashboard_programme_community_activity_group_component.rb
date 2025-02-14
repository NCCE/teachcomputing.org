# frozen_string_literal: true

class PrimaryDashboardProgrammeCommunityActivityGroupComponent < Cms::WithAsidesComponent
  delegate :current_user, to: :helpers

  def initialize(programme_activity_group:)
    aside_sections = if programme_activity_group.web_copy_aside_slug.nil?
      nil
    else
      [{slug: programme_activity_group.web_copy_aside_slug}]
    end

    super(aside_sections:)
    @programme_activity_group = programme_activity_group
  end

  def before_render
    @current_user = current_user
  end
end
