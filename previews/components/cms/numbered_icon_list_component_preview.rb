# frozen_string_literal: true

class Cms::NumberedIconListComponentPreview < ViewComponent::Preview
  def default
    numbered_icon_list = Cms::Mocks::NumberedIconList.as_model
    render(Cms::NumberedIconListComponent.new(
      title: numbered_icon_list.title,
      title_icon: numbered_icon_list.title_icon,
      points: numbered_icon_list.points,
      aside_sections: numbered_icon_list.aside_sections
    ))
  end
end
