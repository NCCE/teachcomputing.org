class Cms::HorizontalCardWithAsidesComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    render(Cms::HorizontalCardWithAsidesComponent.new(
      text: Cms::Mocks::TextComponents::RichBlocks.as_model,
      aside_sections: [],
      background_color: "light-grey",
      color_theme: "standard"
    ))
  end
end
