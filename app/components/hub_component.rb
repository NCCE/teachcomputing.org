# frozen_string_literal: true

class HubComponent < ViewComponent::Base
  def initialize(hub:)
    @hub = hub
  end

end
