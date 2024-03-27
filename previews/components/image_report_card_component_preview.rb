class ImageReportCardComponentPreview < ViewComponent::Preview
  def standard
    params = {
      class_name: "image-report-card-example-component",
      title: "Image Report Card Component",
      text: "This is an example of an image report card component. This is the main body text and it may span multiple, " \
            "lines so our text should attempt to do this too. There will also be some bullet points and a button " \
            "displayed. All are populated by parameters.",
      button: {
        button_title: "Example button",
        button_url: "/"
      },
      image: {
        path: "media/images/pages/impact/impact_report.png",
        alt: "Image"
      }
    }

    render(ImageReportCardComponent.new(**params))
  end

  def with_date
    params = {
      class_name: "image-report-card-example-component",
      date: "May 2021",
      title: "Image Report Card Component",
      text: "This is an example of an image report card component. This is the main body text and it may span multiple lines so our text should attempt to do this too. There will also be some bullet points and a button displayed. All are populated by parameters.",
      button: {
        button_title: "Example button",
        button_url: "/"
      },
      image: {
        path: "media/images/pages/impact/impact_report.png",
        alt: "Image"
      }
    }

    render(ImageReportCardComponent.new(**params))
  end
end
