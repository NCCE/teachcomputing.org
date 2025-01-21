class Cms::EnrichmentComponentPreview < ViewComponent::Preview
  def default
    render(Cms::EnrichmentComponent.new(
      title: Cms::Models::RichHeader.new(blocks: Cms::Mocks::RichBlocks.generate_data),
      details: Cms::Mocks::RichBlocks.generate_data,
      link: "https:://www.teachcomputing.org/test-enrichment",
      i_belong: false,
      type: Cms::Models::EnrichmentType.new(
        name: "Challenge",
        icon: Cms::Mocks::Image.as_model
      ),
      terms: ["Spring", "Autumn"],
      age_groups: ["KS1", "KS3"],
      partner_icon: nil
    ))
  end
end
