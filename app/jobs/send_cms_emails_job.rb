class SendCmsEmailsJob < ApplicationJob
  PER_PAGE = 50
  def perform
    page = 1
    loop do
      email_templates = Cms::Collections::EmailTemplate.all(page, PER_PAGE)
      break if email_templates.resources.empty?

      email_templates.resources.each { process_template(_1) }
      page += 1
    end
  end

  def process_template(template)
    # Do Query
    users = []

    users.each do |user|
      CmsMailer.with(template_slug: template.template.slug, user_id: user.id).send_template.deliver_later
    end
  end
end
