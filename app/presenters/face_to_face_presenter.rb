class FaceToFacePresenter < AchievementPresenter
  include ProgrammesHelper
  include Rails.application.routes.url_helpers

  def button_url(args = {})
    courses_path(course_format: %i[face_to_face remote], certificate: args[:certificate])
  end

  def tracking_data
    { event_action: 'click', event_category: 'Primary enrolled', event_label: 'Book remote or F2F course' }
  end

  def completed_text(index)
    "Completed your #{index_to_word_ordinal(index)} face to face, or remote course"
  end

  def prompt_text(index)
    return t('.prompt_text.html') if FeatureFlagService.new.flags[:primary_redesign_enabled]

    "Complete your #{index_to_word_ordinal(index)} face to face, or remote course"
  end

  def inspect
    "FaceToFacePresenter - empty? #{empty?}\n" + super
  end
end
