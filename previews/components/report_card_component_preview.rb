class ReportCardComponentPreview < ViewComponent::Preview
  def standard
    params = {
      class_name: "report-card-example-component",
      title: "Report Card Component",
      text: "This is an example of a report card component. This is the main body text and it may span multiple, " \
            "lines so our text should attempt to do this too. There will also be some bullet points and a button " \
            "displayed. All are populated by parameters.",
      bullets: ["Item 1", "Item 2", "Item 3"],
      button: {
        button_title: "Example button",
        button_url: "/"
      }
    }

    render(ReportCardComponent.new(**params))
  end

  def with_date
    params = {
      class_name: "report-card-example-component",
      date: "May 2021",
      title: "Report Card Component",
      text: "This is an example of a report card component. This is the main body text and it may span multiple lines so our text should attempt to do this too. There will also be some bullet points and a button displayed. All are populated by parameters.",
      bullets: ["An example of a reasonably long bullet point.", "Another example of a reasonably long bullet point.",
        "A final example of a reasonably long bullet point."],
      button: {
        button_title: "Example button",
        button_url: "/"
      }
    }

    render(ReportCardComponent.new(**params))
  end

  def with_stats_date
    params = {
      class_name: "report-card-example-component",
      title: "Report Card Component",
      text: "This is an example of a report card component. This is the main body text and it may span multiple lines so our text should attempt to do this too. There will also be some bullet points and a button displayed. All are populated by parameters.",
      bullets: ["Item 1", "Item 2", "Item 3"],
      stats_date: "Figure as at April 2021",
      button: {
        button_title: "Example button",
        button_url: "/"
      }
    }

    render(ReportCardComponent.new(**params))
  end
end
