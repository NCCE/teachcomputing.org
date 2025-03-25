# frozen_string_literal: true

class Cms::CurriculumKeyStagesComponentPreview < ViewComponent::Preview
  def default
    render(Cms::CurriculumKeyStagesComponent.new(title: "title", bk_color: "bk_color"))
  end
end
