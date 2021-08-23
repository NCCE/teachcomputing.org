# frozen_string_literal: true

class IsaacCardComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(tracking_category: nil)
    @tracking_category = tracking_category
  end
end
