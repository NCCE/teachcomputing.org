# frozen_string_literal: true

class HeroComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(title:, color: nil, small_title: false, subtitle: nil, status: nil, full_width: false)
    @title = title
    @color = color
    @small_title = small_title
    @subtitle = subtitle
    @status = status
    @full_width = full_width
  end

  def column_width_class
    return "govuk-grid-column-full-width" if @full_width
    "govuk-grid-column-three-quarters"
  end

  def class_list
    ["hero-component",
      color_class].compact.join(" ")
  end

  def heading_class_list
    "#{heading_size_class} hero-component__heading"
  end

  private

  def color_class
    return "hero-component__default" if @color.blank?

    "hero-component__#{@color}"
  end

  def heading_size_class
    return "govuk-heading-l" if @small_title

    "govuk-heading-xl"
  end
end
