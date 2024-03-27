# frozen_string_literal: true

class IBelongFlagComponent < ViewComponent::Base
  def initialize(label: false)
    @label = label
  end
end
