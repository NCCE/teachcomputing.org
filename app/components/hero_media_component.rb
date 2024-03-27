# frozen_string_literal: true

class HeroMediaComponent < ViewComponent::Base
  def initialize(title:, text:, image: nil, video: nil, class_name: nil)
    @title = title
    @text = text
    @image = image
    @video = video
    @class_name = class_name

    raise ArgumentError, "You must define a video or image resource" unless @image || @video
  end
end
