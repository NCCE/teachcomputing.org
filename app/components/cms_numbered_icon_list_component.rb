# frozen_string_literal: true

class CmsNumberedIconListComponent < CmsWithAsidesComponent
  def initialize(title:, title_icon:, points:, aside_sections:)
    super(aside_sections:)
    @title = title
    @title_icon = title_icon
    @points = points
  end
end
