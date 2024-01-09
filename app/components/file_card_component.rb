# frozen_string_literal: true

class FileCardComponent < ViewComponent::Base
  def initialize(file_card:, title: nil, tracking: nil)
    return if file_card.blank?

    @title = title || file_card[:name]
    @file_path = file_card[:file]
    @file_type = file_card[:type]
    @file_size = file_card[:size]
    @file_updated = file_card[:created]

    @tracking_data = tracking unless tracking.blank? || tracking[:category].blank?
  end

  def generate_download_url(current_user, contents_url)
    modified_url = contents_url.dup
    return modified_url << "?user_stem_achiever_contact_no=#{current_user.stem_achiever_contact_no}" if current_user

    contents_url
  end

  def format_date(date)
    DateTime.parse(date).strftime("%d %b %Y")
  end

  def tracking_data(tracking = nil)
    {
      event_action: "click",
      event_category: tracking[:category],
      event_label: tracking[:label] || @title
    }
  end

  def render?
    @file_path.present?
  end
end
