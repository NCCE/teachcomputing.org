# frozen_string_literal: true

class ReportCardComponent < ViewComponent::Base
  def initialize(title:, text:, bullets:, button_title:, button_url:, class_name: nil, date: nil, stats_date: nil)
    @title = title
    @text = text
    @bullets = bullets
    @button_title = button_title
    @button_url = button_url
    @class_name = class_name
    @date = date
    @stats_date = stats_date
  end
end
