class OnlinePresenter < AchievementPresenter
  include ProgrammesHelper
  include Rails.application.routes.url_helpers

  def button_url(args = {})
    courses_path(location: 'Online', certificate: args[:certificate])
  end

  def completed_text(index)
    "Completed your #{index_to_word_ordinal(index)} online course"
  end

  def prompt_text(index)
    return 'Complete at least one online course' if @programme == Programme.secondary_certificate
    "Complete your #{index_to_word_ordinal(index)} online course"
  end

  def inspect
    "OnlinePresenter - empty? #{empty?}\n" + super
  end
end
