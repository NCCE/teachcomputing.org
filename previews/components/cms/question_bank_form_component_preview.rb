# frozen_string_literal: true

class Cms::QuestionBankFromComponentPreview < ViewComponent::Preview
  def default
    render(Cms::QuestionBankFormComponent.new(
      form_name: "Google Form:",
      links: Array.new(2) { Cms::Mocks::Link.as_model }
    ))
  end
end
