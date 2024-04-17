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
    @tracking_category = options[:tracking_category]
    @class_name = options[:class_name]
  end

  def tracking_data(label = nil)
    return nil unless @tracking_category.present? && label.present?

    {
      event_action: "click",
      event_category: @tracking_category,
      event_label: label
    }
  end

  def aside_image_tag(file, *args, **kwargs)
    if file.start_with?("http://", "https://")
      image_tag(file, *args, **kwargs)
    else
      image_pack_tag(file, *args, **kwargs)
    end
  end
end
