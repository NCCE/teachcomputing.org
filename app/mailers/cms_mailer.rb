class CmsMailer < ApplicationMailer
  def send_template
    @template_slug = params[:template_slug]
    @user = User.find(params[:user_id])

    begin
      @template = Cms::Collections::EmailTemplate.get(@template_slug).template

      @subject = @template.subject(@user)

      mail(to: @user.email, subject: @subject)
    rescue ActiveRecord::RecordNotFound
      Sentry.capture_message("Failed to load the email template #{@template_slug}")
    end
  end
end
