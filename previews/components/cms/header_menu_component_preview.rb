# frozen_string_literal: true

class Cms::HeaderMenuComponentPreview < ViewComponent::Preview
  def default
    render(Cms::HeaderMenuComponent.new(
      menu_items: [
        {
          label: "First Item",
          menu_items: [
            { label: "First sub item", url: cms_page_path(:blogs) },
            { label: "Second sub item", url: cms_page_path(:blogs) }
          ]
        },
        {
          label: "Second Item",
          menu_items: [
            { label: "First sub item", url: cms_page_path(:blogs) },
            { label: "Second sub item", url: cms_page_path(:blogs) }
          ]
        }
      ]
    ))
  end
end
