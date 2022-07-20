# frozen_string_literal: true

class CommunityActivityComponentPreview < ViewComponent::Preview
  def default
    render(CommunityActivityComponent.new)
  end
end
