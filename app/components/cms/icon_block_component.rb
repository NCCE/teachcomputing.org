# frozen_string_literal: true

class Cms::IconBlockComponent < ViewComponent::Base
  def initialize(icons:)
    @icons = icons
  end
end
