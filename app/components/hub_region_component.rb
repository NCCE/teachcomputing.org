# frozen_string_literal: true

class HubRegionComponent < ViewComponent::Base
  def initialize(hub_region:)
    @hub_region = hub_region
  end

  def render?
    @hub_region.present?
  end
end
