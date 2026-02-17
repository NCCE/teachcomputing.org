class CmsMailerPreview < ActionMailer::Preview
  def send_template
    template_slug = params[:template_slug].presence || "primary-cert-1a.1"
    user_id = params[:user_id].presence || User.first.id
    CmsMailer.with(user_id:, template_slug:, preview: true).send_template
  end
end
