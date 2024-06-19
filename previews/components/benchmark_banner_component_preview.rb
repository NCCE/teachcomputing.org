class BenchmarkBannerComponentPreview < ViewComponent::Preview
  def default
    render BenchmarkBannerComponent.new(icons: [
      "media/images/pages/careers-support/benchmark_5.svg",
      "media/images/pages/careers-support/benchmark_6.svg",
      "media/images/pages/careers-support/benchmark_7.svg"
    ])
  end
end
