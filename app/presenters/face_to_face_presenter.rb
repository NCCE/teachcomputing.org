class FaceToFacePresenter < AchievementPresenter
  include ProgrammesHelper
  include Rails.application.routes.url_helpers

  def button_url(args = {})
    courses_path(topic: 'Face to face', certificate: args[:certificate])
  end

  def completed_text(index)
    "Completed your #{index_to_word_ordinal(index)} face to face, or remote course"
  end

  def prompt_text(index)
    return 'Complete at least one face to face, or remote course' if @programme == Programme.secondary_certificate
    "Complete your #{index_to_word_ordinal(index)} face to face, or remote course"
  end

  def inspect
    "FaceToFacePresenter - empty? #{empty?}\n" + super
  end
end
