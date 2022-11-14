# frozen_string_literal: true

class TickListCollectionComponent < ViewComponent::Base
  def initialize(tick_lists:)
    @tick_lists = tick_lists
  end

  def render?
    @tick_lists.present?
  end
end
