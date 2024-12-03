# frozen_string_literal: true

class SectionTitleWithIconComponent < ViewComponent::Base
  def initialize(text:, icon: nil, text_size: :medium)
    @text = text
    @icon = icon
    @text_size = text_size
  end

  def text_tag
    case @text_size
    when :medium
      content_tag :h2, @text, class: "govuk-heading-m"
    when :small
      content_tag :h3, @text, class: "govuk-heading-s"
    else
      content_tag :h2, @text, class: "govuk-heading-m"
    end
  end

  def render?
    @text.present?
  end
end
