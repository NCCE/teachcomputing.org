# frozen_string_literal: true

class Cms::HeaderMenuComponentPreview < ViewComponent::Preview
  layout "view_component_preview"

  def default
    render(Cms::RichTextBlockComponent.new(blocks:
      [
        {
          type: "heading",
          level: 1,
          children: [
            {type: "text", text: "Menu Preview"}
          ]
        },
        {
          type: "paragraph",
          children: [
            {type: "text", text: "This heading, and all headings in previews are loaded from Strapi"}
          ]
        }
      ]))
  end
end
