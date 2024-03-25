module CmsHelper
  def cms_image(image)
    image_url = image.image_url
    src = if Rails.env.development?
      "#{Rails.application.config.strapi_image_url}#{image_url}"
    else
      image_url
    end
    image_tag(src, alt: image.alt, class: "ncce-news-and-updates__image")
  end
end
