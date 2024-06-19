class PathwayImprovementsComponentPreview < ViewComponent::Preview
  def default
    pathway = FactoryBot.build(:pathway, improvement_bullets: ["Bullet 1", "Bullet 2", "Bullet 3"], improvement_cta: "Click me!")
    render PathwayImprovementsComponent.new(pathway: pathway)
  end
end
