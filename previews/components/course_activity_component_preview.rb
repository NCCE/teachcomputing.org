# frozen_string_literal: true

class CourseActivityComponentPreview < ViewComponent::Preview
  layout "activity_component_preview"

  def default
    objective = "Complete in <strong>at least one</strong> <em>certificate</em> course.".html_safe
    booking = {
      path: "https://example.com/book",
      tracking_label: "book"
    }
    render CourseActivityComponent.new(objective:, booking:)
  end

  def with_achievements
    objective = "Participate in <strong>at least one</strong> <em>certificate</em> course".html_safe
    booking = {
      path: "https://example.com/book",
      tracking_label: "book"
    }
    achievements = [
      FactoryBot.build(:achievement),
      FactoryBot.build(:achievement, :online),
      FactoryBot.build(:achievement, :remote),
      Achievement.in_state(:completed).first
    ].compact
    render CourseActivityComponent.new(objective:, booking:, achievements:)
  end
end
