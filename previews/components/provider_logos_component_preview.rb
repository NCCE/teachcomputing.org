class ProviderLogosComponentPreview < ViewComponent::Preview
  def dashboard_online
    render(ProviderLogosComponent.new(online: true, dashboard: true))
  end

  def dashboard_other
    render(ProviderLogosComponent.new(online: false, dashboard: true))
  end

  def online
    render(ProviderLogosComponent.new(online: true, dashboard: false))
  end

  def other
    render(ProviderLogosComponent.new(online: false))
  end
end
