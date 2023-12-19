class SendInactivityEmailsJob < ApplicationJob
  def perform
    InactivityQueries.no_activities_completed(Programme.i_belong).each do |user|
      IBelongMailer.with(user:).inactive_not_completed_any_sections.deliver_later
    end

    InactivityQueries.i_belong_completed_appart_from_understand_factors.each do |user|
      IBelongMailer.with(user:).inactive_everything_but_understanding_factors.deliver_later
    end

    InactivityQueries.i_belong_completed_appart_from_access_resources.each do |user|
      IBelongMailer.with(user:).inactive_everything_but_access_resources.deliver_later
    end

    InactivityQueries.i_belong_completed_appart_from_increase_engagement.each do |user|
      IBelongMailer.with(user:).inactive_everything_but_increase_engagement.deliver_later
    end

    InactivityQueries.i_belong_only_one_section_completed.each do |user|
      IBelongMailer.with(user:).inactive_only_completed_one_section.deliver_later
    end
  end
end
