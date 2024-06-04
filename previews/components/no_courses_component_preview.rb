class NoCoursesComponentPreview < ViewComponent::Preview
  def default
    render(NoCoursesComponent.new(hub: FactoryBot.build(:hub)))
  end
end
