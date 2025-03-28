# frozen_string_literal: true

class Cms::AccordionSectionComponentPreview < ViewComponent::Preview
  def default
    render(Cms::AccordionSectionComponent.new(
      title: Faker::Lorem.sentence,
      background_color: nil,
      accordion_block: Array.new(2) {Cms::Mocks::DynamicComponents::ContentBlocks::AccordionBlock.as_model}
    ))
  end
end
