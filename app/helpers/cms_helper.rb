module CmsHelper
  def cms_image_url(image)
    image_url = image.image_url
    if Rails.env.development?
      "#{Rails.application.config.strapi_image_url}#{image_url}"
    else
      image_url
    end
  end

  def cms_image(image)
    image_tag(cms_image_url(image), alt: image.alt, class: "ncce-news-and-updates__image")
  end
end