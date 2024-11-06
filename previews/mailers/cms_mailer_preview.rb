class CmsMailerPreview < ActionMailer::Preview
  def send_template
    CmsMailer.with(user_id: User.first.id, template_slug: "primary-cert-1a.2", preview: true).send_template
  end
end
