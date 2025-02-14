# frozen_string_literal: true

class Cms::IconRowComponent < ViewComponent::Base
  def initialize(icons:)
    @icons = icons
  end
end
