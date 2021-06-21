# frozen_string_literal: true

class HubComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(hub:)
    @hub = hub
  end

  def show_address?
    @hub.address.present? && @hub.postcode.present?
  end
end
