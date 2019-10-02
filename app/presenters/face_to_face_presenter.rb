class FaceToFacePresenter < ActivityPresenter
  include ProgrammesHelper
  include Rails.application.routes.url_helpers

  def button_label(*)
    'Find a face to face course'
  end

  def button_url(args = {})
    courses_path(location: 'Face to face', certificate: args[:certificate])
  end

  def completed_text(index)
    "Completed your #{index_to_word_ordinal(index)} face to face course"
  end

  def prompt_text(index)
    "Complete your #{index_to_word_ordinal(index)} face to face course"
  end

  def inspect
    "FaceToFacePresenter - empty? #{empty?}\n" + super
  end
end
