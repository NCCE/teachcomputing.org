# frozen_string_literal: true

class CmsIconBlockComponent < ViewComponent::Base
  def initialize(icons:)
    @icons = icons
  end
end
