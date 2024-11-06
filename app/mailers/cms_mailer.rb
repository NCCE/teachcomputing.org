class CmsMailer < ApplicationMailer
  def send_template
    template_slug = params[:template_slug]
    user = User.find(params[:user_id])
    template = Cms::Collections::EmailTemplate.get(template_slug).template

    @email_content = template.email_content(user)
    @subject = template.subject

    mail(to: user.email, subject: @subject)
  end
end
