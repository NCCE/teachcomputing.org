# frozen_string_literal: true

class Cms::AccordionBlockComponent < ViewComponent::Base
  def initialize(heading:, summary_text:, text_content:)
    @heading = heading
    @summary_text = summary_text
    @text_content = text_content
  end

end
