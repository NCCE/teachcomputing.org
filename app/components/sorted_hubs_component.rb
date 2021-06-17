# frozen_string_literal: true

class SortedHubsComponent < ViewComponent::Base
  def initialize(sorted_hubs:, formatted_address:)
    @sorted_hubs = sorted_hubs
    @formatted_address = formatted_address
  end

  def render?
    @sorted_hubs.present?
  end
end
