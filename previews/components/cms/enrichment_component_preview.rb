class Cms::EnrichmentComponentPreview < ViewComponent::Preview
  def default
    render(Cms::EnrichmentComponent.new(
      title: Cms::Models::TextComponents::RichHeader.new(blocks: Cms::Mocks::TextComponents::RichBlocks.generate_data),
      details: Cms::Mocks::TextComponents::RichBlocks.generate_data,
      link: "https:://www.teachcomputing.org/test-enrichment",
      i_belong: false,
      type: Cms::Models::EnrichmentComponents::EnrichmentType.new(
        name: "Challenge",
        icon: Cms::Mocks::ImageComponents::Image.as_model
      ),
      terms: ["Spring", "Autumn"],
      age_groups: ["KS1", "KS3"],
      partner_icon: nil
    ))
  end
end
