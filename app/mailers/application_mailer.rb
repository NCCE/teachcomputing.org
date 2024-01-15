class ApplicationMailer < ActionMailer::Base
  helper :external_link

  default from: '"Teach Computing" <noreply@teachcomputing.org>'
  layout "mailer"

  def mail(**args)
    should_send = record_sent_mail(
      to: args[:to],
      record_sent_mail: args[:record_sent_mail],
      mailer_type: args[:mailer_type],
      subject: args[:subject]
    )

    if args[:to].is_a? User
      args[:to] = args[:to].email
    end

    super(**args) if should_send
  end

  def record_sent_mail(to:, subject:, record_sent_mail: false, mailer_type: nil)
    return true if params[:preview]
    return true unless record_sent_mail

    sent_email = SentEmail.new(user: to,
      mailer_type: mailer_type,
      subject: subject)
    sent_email.save!
    true
  rescue => e
    Sentry.capture_message("Error recording email sending: #{e}")
    false
  end
end
