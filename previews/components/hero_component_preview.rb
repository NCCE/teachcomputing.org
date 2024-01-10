class HeroComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    data = {title: "Page title"}
    render(HeroComponent.new(**data))
  end

  def default_small_title
    data = {title: "A smaller title can be used if the page titles are long", small_title: true}
    render(HeroComponent.new(**data))
  end

  def default_with_subtitle
    data = {title: "Page title", subtitle: "A subtitle or date"}
    render(HeroComponent.new(**data))
  end

  def default_with_status
    data = {title: "Page title", status: "User-related status"}
    render(HeroComponent.new(**data))
  end

  def default_with_status_and_subtitle
    data = {title: "Page title", status: "User-related status", subtitle: "A subtitle or date"}
    render(HeroComponent.new(**data))
  end

  def default_with_small_title_status_and_subtitle
    data = {title: "A smaller title can be used if the page titles are long", small_title: true, status: "User-related status", subtitle: "A subtitle or date"}
    render(HeroComponent.new(**data))
  end

  def primary_color
    data = {title: "Page title", color: :primary}
    render(HeroComponent.new(**data))
  end

  def secondary_color
    data = {title: "Page title", color: :secondary}
    render(HeroComponent.new(**data))
  end

  def csa_color
    data = {title: "Page title", color: :csa}
    render(HeroComponent.new(**data))
  end

  def glyphs
    # view at /previews/compononets/hero_component_preview/glyphs.html.erb
    # renders all glyphs available
  end
end
