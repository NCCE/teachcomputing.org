# frozen_string_literal: true

class TickListComponent < ViewComponent::Base
  # QUESTION: Functionally (but not sematically) similar to ReportCardComponent
  # so should we subclass that instead?

  def initialize(title:, text:, bullets:, button:, class_name: nil,
                 show_border: false)
    @title = title
    @text = text
    @bullets = bullets
    @button = button
    @class_name = class_name
    @show_border = show_border
  end
end
