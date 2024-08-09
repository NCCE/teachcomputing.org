# frozen_string_literal: true

class DashboardProgrammeActivityGroupSectionComponent < ViewComponent::Base
  def initialize(title:, programme_activity_group:, current_user:, aside_slug: nil, subtitle: nil)
    @title = title
    @programme_activity_group = programme_activity_group
    @current_user = current_user
    @aside_slug = aside_slug
    @subtitle = subtitle

    @completed = @programme_activity_group.user_complete?(@current_user)

    @aside_model = if @aside_slug
      begin
        Cms::Collections::AsideSection.get(@aside_slug)
      rescue ActiveRecord::RecordNotFound => e
        raise(e) if Rails.env.development?
        nil
      end
    end
  end
end
