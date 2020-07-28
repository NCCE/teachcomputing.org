module CurriculumHelper
  def user_has_rated?(id)
    raw_cookie = cookies.encrypted[:ratings]
    ratings = JSON.parse(raw_cookie) unless raw_cookie.nil?
    ratings&.include?(id)
  end

  def get_feedback_string
      Curriculum::Rateable::EXISTING_FEEDBACK
  end
end
