# frozen_string_literal: true

class ActivityComponentPreview < ViewComponent::Preview
  def default
    data = {
      objective: "I object to things",
      button: {
        text: "Click me",
        path: "https://example.com/thing",
        tracking_label: "clicky thing"
      },
      description: "This component is under construction",
      class_name: "custom_css_class",
      tracking_category: "some category"
    }

    render(ActivityComponent.new(**data))
  end
end
