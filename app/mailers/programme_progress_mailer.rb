class ProgrammeProgressMailer < ApplicationMailer
  def get_started_prompt
    @user = params[:user]
    @programme = Programme.find_by!(slug: params[:slug])
    @subject = 'Thanks for enrolling, do you need some help getting started?'

    mail(to: @user.email, subject: @subject)
  end
end
