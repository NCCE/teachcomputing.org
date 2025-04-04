# frozen_string_literal: true

class Cms::QuestionBankFormComponentPreview < ViewComponent::Preview
  def default
    render(Cms::QuestionBankFormComponent.new(
      form_name: "Google Form",
      links: Array.new(2) { Cms::Mocks::DynamicComponents::ContentBlocks::Link.as_model }
    ))
  end
end
