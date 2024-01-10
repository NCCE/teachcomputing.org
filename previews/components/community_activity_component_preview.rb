# frozen_string_literal: true

require "factory_bot_rails"
require "faker"

class CommunityActivityComponentPreview < ViewComponent::Preview
  layout "activity_component_preview"

  def default
    activity = demo_activity
    render(CommunityActivityComponent.new(achievement: nil, activity:))
  end

  def completed
    achievement = Achievement.in_state(:complete).last.presence || FactoryBot.create(:completed_achievement)
    activity = demo_activity
    render(CommunityActivityComponent.new(achievement:, activity:))
  end

  private

  def demo_activity
    activity = Activity.last.presence || FactoryBot.create(:activity)
    activity.title = "Very long title such as take on a very difficult task, work very hard on it, and publish some evidence about it"
    activity.description = <<~HTML
      <a href="https://www.stem.org.uk/stem-ambassadors/schools-and-colleges" data-event-label="STEM Ambassadors"
      data-event-category="Primary enrolled" data-event-action="click" class="ncce-link">Arrange a visit for your school</a> to
      help pupils understand real-world applications of computing, and raise their career aspirations through engaging
      activities. STEM Ambassadors are inspiring and relatable role models who volunteer to support schools.</div>'
    HTML
    activity
  end
end
