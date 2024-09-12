# frozen_string_literal: true

class CmsNcceButtonComponent < ViewComponent::Base
  def initialize(title:, link:, colour: nil)
    @title = title
    @link = link
    @colour = colour
  end

  def button_classes
    classes = %i[govuk-button button]
    classes << "ncce-button--#{@colour}" if @colour
    classes
  end

  def call
    link_to(@title, @link, class: button_classes)
  end
end
