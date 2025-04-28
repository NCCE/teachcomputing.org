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

    users.each do |user|
      CmsMailer.with(template_slug: data.slug, user_id: user.id).send_template.deliver_later
    end
  end
end
