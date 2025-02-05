# frozen_string_literal: true

class Cms::NumericCardComponent < ViewComponent::Base
  def initialize(title:, text_content:, number:)
    @title = title
    @text_content = text_content
    @number = number
  end
end
