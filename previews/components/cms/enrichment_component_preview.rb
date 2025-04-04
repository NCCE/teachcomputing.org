class Cms::EnrichmentComponentPreview < ViewComponent::Preview
  def default
    render(Cms::EnrichmentComponent.new(
      title: Cms::Models::Text::RichHeader.new(blocks: Cms::Mocks::Text::RichBlocks.generate_data),
      details: Cms::Mocks::Text::RichBlocks.generate_data,
      link: "https:://www.teachcomputing.org/test-enrichment",
      i_belong: false,
      type: Cms::Models::Collections::EnrichmentType.new(
        name: "Challenge",
        icon: Cms::Mocks::Images::Image.as_model
      ),
      terms: ["Spring", "Autumn"],
      age_groups: ["KS1", "KS3"],
      partner_icon: nil
    ))
  end
end
