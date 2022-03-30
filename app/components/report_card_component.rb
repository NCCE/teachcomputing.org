# frozen_string_literal: true

class ReportCardComponent < ViewComponent::Base
  def initialize(title:, text:, bullets:, button:, class_name: nil, date: nil, stats_date: nil, show_border: false)
    @title = title
    @text = text
    @bullets = bullets
    @button = button
    @class_name = class_name
    @date = date
    @stats_date = stats_date
    @show_border = show_border
  end
end
