class FaceToFacePresenter < ActivityPresenter
  include ProgrammesHelper
  include Rails.application.routes.url_helpers

  def button_label(args = {})
    'Find a face to face course'
  end

  def button_url(args = {})
    courses_path(location: 'Face to face', workstream: args[:workstream])
  end

  def completed_text(index)
    "Completed your #{index_to_word_ordinal(index)} face to face course"
  end

  def prompt_text(index)
    "Complete your #{index_to_word_ordinal(index)} face to face course"
  end

  def inspect
    super + "\n\FaceToFacePresenter - empty? #{empty?}\n\n"
  end
end
