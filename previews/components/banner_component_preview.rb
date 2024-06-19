class BannerComponentPreview < ViewComponent::Preview
  include VideosHelper

  def default
    render BannerComponent.new(
      title: "A title",
      text: "Some text to go with it",
      background_color: "isaac",
      box_color: "white",
      video: {url: cs_topic_video_1_url},
      media_column_size: :half,
      media_side: :right,
      wrapper_padding: "top-0",
      button: {text: "Explore careers videos", link: "/tech-careers-videos", class: "ncce-button--white"}
    )
  end
end
