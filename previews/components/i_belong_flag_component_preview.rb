class IBelongFlagComponentPreview < ViewComponent::Preview
  def default
    # Component takes paths to locales and renders the text.
    render(IBelongFlagComponent.new(label: false))
  end
end
