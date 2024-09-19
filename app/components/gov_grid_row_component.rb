# frozen_string_literal: true

class GovGridRowComponent < ViewComponent::Base
  delegate :govuk_padding_classes, :govuk_margin_classes,
    to: :helpers

  renders_many :columns, "GovGridColumnComponent"

  def initialize(background_color: nil, padding: {}, margin: {}, additional_classes: nil)
    @background_color = background_color
    @padding = padding
    @margin = margin
    @additional_classes = additional_classes
  end

  def wrapper_classes
    classes = ["tc-gov-grid-wrapper"]
    classes << "#{@background_color}-bg" if @background_color
    classes += Array.wrap(@additional_classes)
    classes
  end

  def main_wrapper_classes
    ["govuk-main-wrapper"] + govuk_padding_classes(@padding) + govuk_margin_classes(@margin)
  end

  class GovGridColumnComponent < ViewComponent::Base
    delegate :govuk_padding_classes, :govuk_margin_classes,
      to: :helpers

    def initialize(column_type, padding: {}, margin: {})
      @column_type = column_type
      @padding = padding
      @margin = margin
    end

    def column_classes
      ["govuk-grid-column-#{@column_type}"] + govuk_padding_classes(@padding) + govuk_margin_classes(@margin)
    end

    def call
      content_tag :div, content, {class: column_classes}
    end
  end
end
