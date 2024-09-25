class CmsPictureCardComponent < ViewComponent::Base
  def initialize(image:, title:, body_text:, link:)
    @image = image
    @title = title
    @body_text = body_text
    @link = link
  end
end
