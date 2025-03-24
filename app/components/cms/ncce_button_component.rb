# frozen_string_literal: true

class Cms::NcceButtonComponent < ViewComponent::Base
  delegate :current_user, to: :helpers

  def initialize(title:, link:, color: nil, logged_in_title: nil, logged_in_link: nil)
    @title = title
    @link = link
    @color = color
    @logged_in_title = logged_in_title
    @logged_in_link = logged_in_link
  end

  def button_classes
    classes = %i[govuk-button button]
    classes << "ncce-button--#{@color}" if @color
    classes
  end

  def link
    return @logged_in_link if @logged_in_link && current_user
    @link
  end

  def title
    return @logged_in_title if @logged_in_title && current_user
    @title
  end

  def call
    link_to(title, link, class: button_classes)
  end
end
