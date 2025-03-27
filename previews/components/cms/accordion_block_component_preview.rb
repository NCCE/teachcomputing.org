# frozen_string_literal: true

class Cms::AccordionBlockComponentPreview < ViewComponent::Preview
  def default
    render(Cms::AccordionBlockComponent.new(heading: "heading", summary_text: "summary_text", content: "content"))
  end
end
