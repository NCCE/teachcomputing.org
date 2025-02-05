class CmsMailer < ApplicationMailer
  def send_template
    @template = params[:template]
    @user = User.find(params[:user_id])

    @subject = @template.subject(@user)

    mail(to: @user.email, subject: @subject)
  end
end
