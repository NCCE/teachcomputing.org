# frozen_string_literal: true

class PrimaryDashboardActivityComponent < CmsWithAsidesComponent
  def initialize(programme_activities:)
    @programme_activities = programme_activities
  end
end
