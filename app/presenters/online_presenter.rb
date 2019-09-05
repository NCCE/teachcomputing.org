class OnlinePresenter < ActivityPresenter
  include ProgrammesHelper
  include Rails.application.routes.url_helpers

  def button_label(args = {})
    'Find an online course'
  end

  def button_url(args = {})
    courses_path(location: 'Online', workstream: args[:workstream])
  end

  def completed_text(index)
    "Completed your #{index_to_word_ordinal(index)} online course"
  end

  def prompt_text(index)
    "Complete your #{index_to_word_ordinal(index)} online course"
  end

  def inspect
    super + "\n\OnlinePresenter - empty? #{empty?}\n\n"
  end
end

