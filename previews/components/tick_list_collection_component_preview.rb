class TickListCollectionComponentPreview < ViewComponent::Preview
  def default
    title = "Tick List Collection Component"
    tick_list_collection = [
      {
        class_name: "tick-list-example-component",
        title: "Tick List Component 1",
        text: "This is an example of a tick list component. This is the main " \
              "body text and it may span multiple lines so our text should " \
              "attempt to do this too. There will also be some bullet points " \
              "and a button displayed. All are populated by parameters.",
        bullets: ["Item 1", "Item 2", "Item 3"],
        button: {
          button_title: "Example button",
          button_url: "/"
        }
      },
      {
        class_name: "tick-list-example-component",
        title: "Tick List Component 2",
        text: "This is another example of a tick list component. This is the " \
              "main body text and it may span multiple lines so our text " \
              "should attempt to do this too. There will also be some bullet " \
              "points and a button displayed. All are populated by parameters.",
        bullets: ["Item 1", "Item 2", "Item 3"],
        button: {
          button_title: "Example button",
          button_url: "/"
        }
      }
    ]
    render(TickListCollectionComponent.new(tick_list_collection:, title:))
  end
end
