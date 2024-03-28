class SeoBlockComponent < ViewComponent::Base
  delegate :meta_tag, to: :helpers

  def initialize(title, description)
    @title = title
    @description = description
  end

  def call
    meta_tag(:title, @title)
    meta_tag(:description, @description)
  end
end
