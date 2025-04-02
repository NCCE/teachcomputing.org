class Cms::LinkComponentPreview < ViewComponent::Preview
  def default
    render Cms::LinkComponent.new(
      url: Faker::Internet.url,
      link_text: Faker::Lorem.sentence
    )
  end
end
