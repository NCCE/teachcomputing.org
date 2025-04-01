# frozen_string_literal: true

class Cms::CommunityActivityGridComponentPreview < ViewComponent::Preview
  def default
    render(
      Cms::CommunityActivityGridComponent.new(
        title: "Step two: Developing your teaching practice",
        intro: Cms::Mocks::TextComponents::RichBlocks.as_model,
        programme_activity_group_slug: "primary-develop-practice"
      )
    )
  end
end
