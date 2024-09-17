module CmsHelper
  def cms_url(url)
    if Rails.env.development?
      return url if url.starts_with?("http")
      "#{Rails.application.config.strapi_image_url}#{url}"
    else
      url
    end
  end

  def cms_image_url(image)
    cms_url(image.image_url)
  end

  def cms_image(image, class: nil)
    image_tag(cms_image_url(image), alt: image.alt, class:)
  end

  def cms_colour_theme(colour, side)
    "cms-colour-theme__border--#{colour}-#{side}"
  end
end
