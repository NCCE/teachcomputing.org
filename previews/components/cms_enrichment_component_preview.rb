class CmsEnrichmentComponentPreview < ViewComponent::Preview
  def default
    params = {
      title: [{
        type: "paragraph",
        children: [
          {
            text: "Do your: bit",
            type: "text"
          }
        ]
      }],
      details: [{
        type: "paragraph",
        children: [
          {
            text: "Bring together the micro:bit and the UN’s Global Goals to provide inspiring activities for your classroom or club and an exciting digital challenge for you to run.",
            type: "text"
          }
        ]
      }],
      type: "Challenge",
      link: "https://www.google.com",
      terms: ["Summer"],
      age_groups: ["7 - 11 years"],
      i_belong: false,
      partner_icon: nil
    }

    render(CmsEnrichmentComponent.new(**params))
  end
end
