class SendInactivityEmailsJob < ApplicationJob
  def perform

  end

  def i_belong_none_completed
    users.each do |user|
      # Send email
    end
  end

  def i_belong_only_completed_one_section
    users.each do |user|
      # send email
    end
  end

  def i_belong_completed_x_appart_from
    users.each do |user|
      # send email
    end
  end

  def primary_or_secondary(certificate)
    users.each do |user|
      # send email
    end
  end
end
