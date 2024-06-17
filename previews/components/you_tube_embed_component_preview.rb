class YouTubeEmbedComponentPreview < ViewComponent::Preview
  # Component takes a YouTube video Url and embeds in an iframe
  def standard
    params = {
      video_url: "https://www.youtube.com/watch?v=t0ojrm0fMoE&list=PLwcV67XMdDdJn_6BFs2h1yBeyZDArab7J&index=3"
    }
    render(YouTubeEmbedComponent.new(**params))
  end
end
