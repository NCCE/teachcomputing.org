class Cms::PageTitleComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    render(Cms::PageTitleComponent.new(title: "Page title", sub_text: nil))
  end

  def with_sub_text
    render(Cms::PageTitleComponent.new(title: "Page title", sub_text: "Welcome to the page"))
  end

  def with_image
    render(Cms::PageTitleComponent.new(
      title: "Page title",
      sub_text: "Welcome to the page",
      title_image: Cms::Mocks::Images::Image.as_model
    ))
  end

  def with_video
    render(Cms::PageTitleComponent.new(
      title: "Page title",
      sub_text: "Welcome to the page",
      title_video_url: "https://www.youtube.com/watch?v=-fTboqiyjxk&list=PLwcV67XMdDdJT0TkvZo6cTDSR0uJgP3Ku"
    ))
  end

  def with_background_color
    render(Cms::PageTitleComponent.new(
      title: "Page title",
      sub_text: "Welcome to the page",
      background_color: "orange"
    ))
  end

  def with_i_belong_flag
    render(Cms::PageTitleComponent.new(
      title: "Page title",
      sub_text: "Welcome to the page",
      background_color: "orange",
      i_belong_flag: true
    ))
  end
end
