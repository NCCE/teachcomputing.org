# frozen_string_literal: true

class DashboardProgrammeActivityGroupSectionComponent < ViewComponent::Base
  def initialize(anchor_id:, title: nil, completed: false, aside_slug: nil, subtitle: nil)
    @title = title
    @aside_slug = aside_slug
    @subtitle = subtitle
    @completed = completed
    @anchor_id = anchor_id

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
