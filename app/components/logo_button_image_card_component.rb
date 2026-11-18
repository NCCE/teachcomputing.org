# frozen_string_literal: true

class LogoButtonImageCardComponent < ViewComponent::Base
  def initialize(image:, logo:, title:, text:, button:, class_name: nil)
    @image = image
    @logo = logo
    @title = title
    @text = text
    @button = button
    @class_name = class_name
  end
end
