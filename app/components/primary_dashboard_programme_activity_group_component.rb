# frozen_string_literal: true

class PrimaryDashboardProgrammeActivityGroupComponent < CmsWithAsidesComponent
  def initialize(title:, programme_activity_group:, community_achievements:, aside_slug: nil)
    super(aside_sections: [{slug: aside_slug}])
    @title = title
    @programme_activity_group = programme_activity_group

    @programme_activities = @programme_activity_group.programme_activities.not_legacy do |programme_activity|
      Activity.find(programme_activity.activity_id)
    end
  end
end
