class OnlinePresenter < AchievementPresenter
  include ProgrammesHelper
  include Rails.application.routes.url_helpers

  def button_url(args = {})
    courses_path(course_format: [:online], certificate: args[:certificate])
  end

  def tracking_data
    { event_action: 'click', event_category: 'Primary enrolled', event_label: 'Book online course' }
  end

  def prompt_text(index)
    return t('.prompt_text.html')
  end

  def inspect
    "OnlinePresenter - empty? #{empty?}\n" + super
  end
end
