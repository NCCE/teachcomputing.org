# frozen_string_literal: true

class FeedbackComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(heading:, area:)
    @heading = heading
    @area = area
  end
end
