# frozen_string_literal: true

class Cms::EmbeddedVideoComponentPreview < ViewComponent::Preview
  def local
    render(
      Cms::EmbeddedVideoComponent.new(
        url: "https://static.teachcomputing.org/How_important_is_the_I_Belong_programme.mp4"
      )
    )
  end

  def youtube
    render(
      Cms::EmbeddedVideoComponent.new(
        url: "https://www.youtube.com/watch?v=-fTboqiyjxk&list=PLwcV67XMdDdJT0TkvZo6cTDSR0uJgP3Ku"
      )
    )
  end
end
