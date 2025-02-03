# frozen_string_literal: true

class DashboardProgrammeActivityGroupSectionComponent < Cms::WithAsidesComponent
  def initialize(anchor_id:, title: nil, completed: false, aside_slug: nil, subtitle: nil)
    aside_sections = if aside_slug.nil?
      nil
    else
      [{slug: aside_slug}]
    end

    super(aside_sections:)
    @title = title
    @subtitle = subtitle
    @completed = completed
    @anchor_id = anchor_id
  end
end
