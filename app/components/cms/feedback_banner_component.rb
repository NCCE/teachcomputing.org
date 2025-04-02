# frozen_string_literal: true

class Cms::FeedbackBannerComponent < ViewComponent::Base
  def initialize(title:, button:)
    @title = title
    @button = button
  end
end
