class RelatedLinksComponentPreview < ViewComponent::Preview
  def standard
    params = {
      class_name: "related-links-example-component",
      links: [
        {
          link_title: "A link",
          link_url: "/"
        },
        {
          link_title: "Another link",
          link_url: "/",
          tracking_page: "Impact",
          tracking_label: "A link of interest"
        }
      ]
    }

    render(RelatedLinksComponent.new(**params))
  end
end
