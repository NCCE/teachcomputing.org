module CmsHelper
  def cms_image_url(url)
    "#{ENV["CMS_IMAGE_URL"]}#{url}"
  end
end
