# frozen_string_literal: true

class Cms::CommunityActivityListComponentPreview < ViewComponent::Preview
  def default
    render(
      Cms::CommunityActivityListComponent.new(
        title: "Step two: Developing your teaching practice",
        intro_text: Cms::Mocks::RichBlocks.as_model,
        programme_activity_group_slug: "Develop your teaching practice"
      )
    )
  end
end
