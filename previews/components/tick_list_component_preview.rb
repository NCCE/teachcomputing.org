# frozen_string_literal: true

class TickListComponentPreview < ViewComponent::Preview
  def standard
    tick_list = {
      class_name: "tick-list-example-component",
      title: "Tick List Component",
      text: "This is an example of a tick list component. This is the main " \
            "body text and it may span multiple lines so our text should " \
            "attempt to do this too. There will also be some bullet points " \
            "and a button displayed. All are populated by parameters.",
      bullets: ["Item 1", "Item 2", "Item 3"],
      button: {
        button_title: "Example button",
        button_url: "/"
      }
    }

    render(TickListComponent.new(tick_list:))
  end
end
