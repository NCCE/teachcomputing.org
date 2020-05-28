class ApplicationMailer < ActionMailer::Base
  default from: '"Teach Computing" <noreply@teachcomputing.org>'
  layout 'mailer'

  def mail(**args)
    record_sent_mail(args)
    super(**args)
  end

  def record_sent_mail(record_sent_mail: false, to:, mailer_type: nil, subject:)
    if record_sent_mail == true
      user = User.find_by!(email: to)

      sent_email = SentEmail.new(user: user,
                                mailer_type: mailer_type,
                                subject: subject)
      sent_email.save!
    end
  end
end
