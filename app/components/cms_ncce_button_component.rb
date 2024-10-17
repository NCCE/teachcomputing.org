# frozen_string_literal: true

class CmsNcceButtonComponent < ViewComponent::Base
  def initialize(title:, link:, color: nil)
    @title = title
    @link = link
    @color = color
  end

  def button_classes
    classes = %i[govuk-button button]
    classes << "ncce-button--#{@color}" if @color
    classes
  end

  def call
    link_to(@title, @link, class: button_classes)
  end
end
