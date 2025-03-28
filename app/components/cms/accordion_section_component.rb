# frozen_string_literal: true

class Cms::AccordionSectionComponent < ViewComponent::Base
  def initialize(id:, title:, background_color:, accordion_block:)
    @id = id
    @title = title
    @background_color = background_color
    @accordion_block = accordion_block
  end
end
