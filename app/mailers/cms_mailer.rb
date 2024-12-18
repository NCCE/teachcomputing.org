class CmsMailer < ApplicationMailer
  def send_template
    template_slug = params[:template_slug]
    @user = User.find(params[:user_id])
    @template = Cms::Collections::EmailTemplate.get(template_slug).template

    @subject = @template.subject

    mail(to: @user.email, subject: @subject)
  end
end
