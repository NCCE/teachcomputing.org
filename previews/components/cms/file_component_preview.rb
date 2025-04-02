class Cms::FileComponentPreview < ViewComponent::Preview
  def default
    file = Cms::DynamicComponents::ContentBlocks::FileLink.new(
      url: "https://strapi.teachcomputing.org/test_file.pdf",
      filename: "Test File",
      size: 45,
      updated_at: DateTime.new(2024, 8, 9)
    )

    render Cms::FileComponent.new(file:)
  end
end
