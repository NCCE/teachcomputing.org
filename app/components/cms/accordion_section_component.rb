# frozen_string_literal: true

class Cms::AccordionSectionComponent < ViewComponent::Base
  def initialize(id:, accordion_block:, title: nil, background_color: nil)
    @id = id
    @title = title
    @background_color = background_color
    @accordion_block = accordion_block
  end
end
