class ReportCardComponentPreview < ViewComponent::Preview
  def default
    params = OpenStruct.new(
      {
        class_name: 'report-card-example-component',
        date: 'May 2021',
        title: 'Report Card Component',
        text: 'This is an example of a report card component. This is the main body text and it may span multiple, ' \
              'lines so our text should attempt to do this too. There will also be some bullet points and a button ' \
              'displayed. All are populated by parameters.',
        bullets: ['Item 1', 'Item 2', 'Item 3'],
        button: OpenStruct.new(
          text: 'Example button',
          path: '/'
        )
      }
    )

    render(ReportCardComponent.new(params))
  end
end
