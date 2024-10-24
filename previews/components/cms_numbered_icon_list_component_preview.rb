# frozen_string_literal: true

class CmsNumberedIconListComponentPreview < ViewComponent::Preview
  def default
    render(CmsNumberedIconListComponent.new(title: "title", title_icon: "title_icon", points: "points"))
  end
end
