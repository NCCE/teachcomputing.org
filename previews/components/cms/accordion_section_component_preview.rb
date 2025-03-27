# frozen_string_literal: true

class Cms::AccordionSectionComponentPreview < ViewComponent::Preview
  def default
    render(Cms::AccordionSectionComponent.new(title: "title", bk_color: "bk_color", accordion_block: "accordion_block"))
  end
end
