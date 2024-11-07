# frozen_string_literal: true

class DashboardProgrammeActivityGroupSectionComponent < CmsWithAsidesComponent
  def initialize(anchor_id:, title: nil, completed: false, aside_slug: nil, subtitle: nil)
    super(aside_sections: [{slug: aside_slug}])
    @title = title
    @subtitle = subtitle
    @completed = completed
    @anchor_id = anchor_id
  end
end
