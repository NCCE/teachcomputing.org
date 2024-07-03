class GovGridRowComponentPreview < ViewComponent::Preview
  layout "full-width"

  def two_thirds_one_third
    component = GovGridRowComponent.new.tap do |c|
      c.with_column("two-thirds") do
        "Two thirds column"
      end
      c.with_column("one-third") do
        "One third column"
      end
    end
    render(component)
  end

  def two_thirds_one_third_purple_bg
    component = GovGridRowComponent.new(
      background_color: "purple"
    ).tap do |c|
      c.with_column("two-thirds") do
        "Two thirds column"
      end
      c.with_column("one-third") do
        "One third column"
      end
    end
    render(component)
  end

  def grey_with_padding
    component = GovGridRowComponent.new(
      background_color: "light-grey",
      padding: {all: 5}
    ).tap do |c|
      c.with_column("one-third") do
        "One third column"
      end
      c.with_column("two-thirds") do
        "Two thirds column"
      end
    end
    render(component)
  end
end
