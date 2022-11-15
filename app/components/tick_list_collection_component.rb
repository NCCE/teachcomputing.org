# frozen_string_literal: true

class TickListCollectionComponent < ViewComponent::Base
  def initialize(tick_list_collection:)
    @tick_list_collection = tick_list_collection
  end

  def render?
    @tick_list_collection.present?
  end
end
