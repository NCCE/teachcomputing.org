# frozen_string_literal: true

class Cms::AccordionSectionComponent < ViewComponent::Base
  def initialize(title:, bk_color:, accordion_block:)
    @title = title
    @bk_color = bk_color
    @accordion_block = accordion_block
  end

end
