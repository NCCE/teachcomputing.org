# frozen_string_literal: true

class HubSearchComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(location:)
    @location = location
  end
end
