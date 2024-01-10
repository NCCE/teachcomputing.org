class NoticeComponentPreview < ViewComponent::Preview
  def default
    render(
      NoticeComponent.new(
        class_name: "lime-green-bg",
        icon: {
          url: "media/images/icons/raspberry-pi.svg",
          title: "Raspberry Pi"
        },
        title: "Notice",
        text: "This is a notice with some information relevent to something somewhere on the site.",
        link: {
          url: "/",
          text: "Another place",
          tracking_label: "Something"
        },
        tracking_category: "Notice"
      )
    )
  end
end
