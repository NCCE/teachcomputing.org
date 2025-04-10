# frozen_string_literal: true

class Cms::AccordionSectionComponent < ViewComponent::Base
  def initialize(id:, accordion_blocks:, title: nil, background_color: nil)
    @id = id
    @title = title
    @background_color = background_color
    @accordion_blocks = accordion_blocks
  end
end
