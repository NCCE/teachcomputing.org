# frozen_string_literal: true

class IconRowComponent < ViewComponent::Base
  def initialize(icons:)
    @icons = icons
  end
end
