class CertificateMailer < ApplicationMailer
  def completed
    @user = params[:user]
    @programme = params[:programme]

    @official_programme_titles = { 'primary-certificate': 'National Centre for Computing Education Certificate in Primary Computing Teaching',
                                   'cs-accelerator': 'National Centre for Computing Education Certificate in Primary Computing Teaching' }

    mail(to: @user.email, subject: "Congratulations you have completed the #{@official_programme_titles[@programme.slug.to_sym]}")
  end
end
