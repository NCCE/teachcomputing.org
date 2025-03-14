# frozen_string_literal: true

class Cms::IconRowComponent < ViewComponent::Base
  def initialize(icons:, background_color:)
    @icons = icons
    @background_color = background_color
  end
end
