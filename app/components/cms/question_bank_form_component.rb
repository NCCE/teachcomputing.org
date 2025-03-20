# frozen_string_literal: true

class Cms::QuestionBankFormComponent < ViewComponent::Base
  def initialize(form_name:, links:)
    @form_name = form_name
    @links = links
  end
end
