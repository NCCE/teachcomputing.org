# frozen_string_literal: true

class ReportCardComponent < ViewComponent::Base
  def initialize(class_name:, title:, text:, bullets:, button_title:, button_url:, date: nil, stats_date: nil)
    @class_name = class_name
    @title = title
    @date = date
    @text = text
    @bullets = bullets
    @stats_date = stats_date
    @button_title = button_title
    @button_url = button_url
  end
end
