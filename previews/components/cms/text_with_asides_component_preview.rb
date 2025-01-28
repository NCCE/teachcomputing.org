class Cms::TextWithAsidesComponentPreview < ViewComponent::Preview
  def default
    render Cms::TextWithAsidesComponent.new(
      blocks: Cms::Mocks::RichBlocks.as_model,
      asides: [],
      background_color: "nil"
    )
  end
end
