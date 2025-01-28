# frozen_string_literal: true

class Cms::FileComponent < ViewComponent::Base
  delegate :cms_url, to: :helpers

  def initialize(file:)
    @file = file
  end
end
