module CmsHelper
  def cms_image image_data, size
    image_url = if image_data[:formats].has_key? size.to_sym
      image_data[:formats][size.to_sym][:url]
    else
      image_data[:url]
    end
    src = if Rails.env.development?
      "http://strapi.teachcomputing.rpfdev.com#{image_url}"
    else
      image_url
    end
    image_tag src, alt: image_data[:alternativeText], class: "ncce-news-and-updates__image"
  end
end
