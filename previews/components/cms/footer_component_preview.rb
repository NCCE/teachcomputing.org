# frozen_string_literal: true

class Cms::FooterComponentPreview < ViewComponent::Preview
  layout "view_component_preview"

  def default
    render(Cms::RichTextBlockComponent.new(blocks:
      [
        {
          type: "heading",
          level: 1,
          children: [
            {type: "text", text: "Footer Preview"}
          ]
        },
        {
          type: "paragraph",
          children: [
            {type: "text", text: "This footer, and all link blocks in previews are loaded from Strapi"}
          ]
        }
      ]))
  end
end
