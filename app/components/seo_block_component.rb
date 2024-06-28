class SeoBlockComponent < ViewComponent::Base
  delegate :meta_tag, :cms_image_url, to: :helpers

  def initialize(title:, description:, featured_image:)
    @title = title
    @description = description
    @featured_image = featured_image
  end

  def call
    meta_tag(:title, "#{@title} - Teach Computing")
    meta_tag(:description, @description)
    meta_tag(:image, cms_image_url(@featured_image)) if @featured_image
  end
end
