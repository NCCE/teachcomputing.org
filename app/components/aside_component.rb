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
    @cms_content = options[:cms_content]
    @aside_icons = options[:aside_icons]
    @show_heading_line = if options[:show_heading_line].nil?
      true
    else
      @show_heading_line = options[:show_heading_line]
    end
  end

  def aside_classes
    classes = ["aside-component"]
    classes << "with-heading-line" if @show_heading_line
    classes << @class_name if @class_name
    classes.join(" ")
  end

  def aside_image_tag(file, *args, **kwargs)
    if file.start_with?("http://", "https://")
      image_tag(file, *args, **kwargs)
    else
      image_pack_tag(file, *args, **kwargs)
    end
  end
end
