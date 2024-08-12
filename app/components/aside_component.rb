# frozen_string_literal: true

class AsideComponent < ViewComponent::Base
  renders_one :heading
  renders_one :body

  def initialize(text: nil, title: nil, link: nil, **options)
    @title = title
    @text = text
    @link = link
    @image = options[:image]
    @use_button = options[:use_button]
    @class_name = options[:class_name]
    @cms_blocks = options[:cms_blocks]
    @cms_files = options[:cms_files]
  end

  def aside_image_tag(file, *args, **kwargs)
    if file.start_with?("http://", "https://")
      image_tag(file, *args, **kwargs)
    else
      image_pack_tag(file, *args, **kwargs)
    end
  end
end
