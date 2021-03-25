class ApplicationMailer < ActionMailer::Base
  default from: '"Teach Computing" <noreply@teachcomputing.org>'
  layout 'mailer'

  def mail(**args)
    should_send = record_sent_mail(
      to: args[:to],
      record_sent_mail: args[:record_sent_mail],
      mailer_type: args[:mailer_type],
      subject: args[:subject]
    )
    super(**args) if should_send
  end

  def record_sent_mail(record_sent_mail: false, to:, mailer_type: nil, subject:)
    return true unless record_sent_mail

    user = User.find_by!(email: to)

    sent_email = SentEmail.new(user: user,
                               mailer_type: mailer_type,
                               subject: subject)
    sent_email.save!
    true
  rescue StandardError => e
    Sentry.capture_message("Error recording email sending: #{e}")
    false
  end
end
