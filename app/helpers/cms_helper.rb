module CmsHelper
  def cms_image(image, size)
    image_url = if image.formats&.has_key? size.to_sym
      image.formats[size.to_sym][:url]
    else
      image.url
    end
    src = if Rails.env.development?
      "#{ENV["STRAPI_IMAGE_URL"]}#{image_url}"
    else
      image_url
    end
    image_tag(src, alt: image.alt, class: "ncce-news-and-updates__image")
  end
end
