class ProviderLogosComponentPreview < ViewComponent::Preview
  def booking_aside
    render(ProviderLogosComponent.new(dashboard: false))
  end

  def dashboard_default
    # provided by stem_learning
    render(ProviderLogosComponent.new)
  end

  def dashboard_retired
    render(ProviderLogosComponent.new(dashboard: true, provider: "future-learn"))
  end
end
