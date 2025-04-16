# frozen_string_literal: true

class Cms::AccordionSectionComponentPreview < ViewComponent::Preview
  def default
    render(Cms::AccordionSectionComponent.new(
      id: 1,
      title: Faker::Lorem.sentence,
      background_color: nil,
      accordion_blocks:
      Cms::Providers::Strapi::Factories::BlocksFactory.to_accordion_block_array(
        Array.new(3) { Cms::Mocks::DynamicComponents::ContentBlocks::AccordionBlock.generate_raw_data }
      )
    ))
  end
end
