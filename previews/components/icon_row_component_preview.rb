class IconRowComponentPreview < ViewComponent::Preview
  def default
    render(IconRowComponent.new(icons:))
  end

  private

  def icons
    [
      {image_url: "media/images/icons/curriculum.svg", text: "Curriculum design"},
      {image_url: "media/images/icons/subject_knowledge.svg", text: "Subject knowledge"},
      {image_url: "media/images/icons/physical_computing_kits.svg", text: "Physical computing kits"},
      {image_url: "media/images/icons/real_world.svg", text: "Real-world contexts"},
      {image_url: "media/images/icons/subject_matter_experts.svg", text: "Subject matter experts support"}
    ]
  end
end
