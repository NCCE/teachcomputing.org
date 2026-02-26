class SendCmsEmailsJob < ApplicationJob
  PER_PAGE = 50
  def perform
    email_templates = Cms::Collections::EmailTemplate.all_records
    email_templates.each { process_template(_1) }
  end

  def process_template(template)
    # Do Query
    data = template.template
    users = Programmes::ProgressQuery.new(data.programme, data.activity_state, data.enrolled, data.completed_programme_activity_groups).call

    user_ids = users.pluck(:id)

    users_to_email = user_ids - User.joins(:sent_emails)
      .where(sent_emails: {mailer_type: data.slug})
      .where(id: user_ids)
      .pluck(:id)

    users_to_email.each do |user|
      CmsMailer.with(template_slug: data.slug, user_id: user).send_template.deliver_later
    end
  end
end
