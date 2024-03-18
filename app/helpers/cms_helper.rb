module CmsHelper
  def cms_image(image)
    image_url = image.image_url
    src = if Rails.env.development?
      "#{ENV["STRAPI_IMAGE_URL"]}#{image_url}"
    else
      image_url
    end
    image_tag(src, alt: image.alt, class: "ncce-news-and-updates__image")
  end
end
