class Cms::HomepageHeroComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    render(Cms::HomepageHeroComponent.new(
      title: "Helping you teach computing",
      house_content: Cms::Mocks::RichBlocks.as_model,
      buttons: [
        Cms::Mocks::DynamicComponents::Buttons::NcceButton.as_model
      ]
    ))
  end
end
