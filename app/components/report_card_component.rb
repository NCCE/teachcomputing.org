# frozen_string_literal: true

class ReportCardComponent < ViewComponent::Base
  def initialize(title:, text:, bullets:, button:, class_name: nil, date: nil, stats_date: nil, show_border: false)
    @title = title
    @text = text
    @bullets = bullets
    @button = assign_button(button)
    @class_name = class_name
    @date = date
    @stats_date = stats_date
    @show_border = show_border
  end

  def assign_button(button_title:, button_url:, tracking_page: nil, tracking_label: nil)
    { button_title: button_title, button_url: button_url, tracking_page: tracking_page, tracking_label: tracking_label }
  end
end
