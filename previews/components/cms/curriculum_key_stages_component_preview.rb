# frozen_string_literal: true

class Cms::CurriculumKeyStagesComponentPreview < ViewComponent::Preview
  def default
    render(Cms::CurriculumKeyStagesComponent.new(title: "Resources for you", background_color: "white"))
  end
end
