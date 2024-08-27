# frozen_string_literal: true

class CmsPageTitleComponent < ViewComponent::Base
  def initialize(title:, intro_text:)
    @title = title
    @intro_text = intro_text
  end

end
