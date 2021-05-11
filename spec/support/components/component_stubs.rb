module ComponentStubs
  def report_card_stub(date = nil)
    OpenStruct.new(
      {
        class_name: 'report-card-example-component',
        date: date,
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
  end

  def hero_image_stub
    OpenStruct.new(
      {
        class_name: 'hero-image-example-component',
        title: 'Hero Image Component',
        text: "This is an example of a hero image component. It's a hero and it has an image, it also has some text.",
        image: 'media/images/landing-pages/pri-hero.png'
      }
    )
  end
end
