# frozen_string_literal: true

class NoHubsComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(sorted_hubs:, hub_regions:)
    @sorted_hubs = sorted_hubs
    @hub_regions = hub_regions
  end

  def render?
    @sorted_hubs.blank? && @hub_regions.blank?
  end
end
