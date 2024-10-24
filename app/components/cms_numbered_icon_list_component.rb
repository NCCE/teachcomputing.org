# frozen_string_literal: true

class CmsNumberedIconListComponent < ViewComponent::Base
  def initialize(title:, title_icon:, points:)
    @title = title
    @title_icon = title_icon
    @points = points
  end

end
