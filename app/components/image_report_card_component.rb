# frozen_string_literal: true

class ImageReportCardComponent < ViewComponent::Base
  def initialize(title:, text:, button:, image:, class_name: nil, date: nil, show_border: false)
    @title = title
    @text = text
    @button = button
    @class_name = class_name
    @date = date
    @show_border = show_border
    @image = image
  end
end
