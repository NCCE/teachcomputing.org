class Cms::RichTextBlockComponentPreview < ViewComponent::Preview
  def default
    render Cms::RichTextBlockComponent.new(blocks:
      [
        {type: "heading",
         level: 1,
         children: [
           {type: "text", text: "Heading large"}
         ]},
        {type: "heading",
         level: 2,
         children: [
           {type: "text", text: "Heading medium"}
         ]},
        {type: "paragraph",
         children: [
           {type: "text", text: "Standard paragraph"}
         ]},
        {type: "text", text: "Code text", code: true},
        {
          type: "list",
          format: "ordered",
          children: [
            {type: "list-item", children: [{type: "text", text: "Item 1"}]},
            {type: "list-item", children: [{type: "text", text: "Item 2"}]}
          ]
        }
      ])
  end
end
