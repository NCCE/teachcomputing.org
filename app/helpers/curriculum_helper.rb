module CurriculumHelper
  def get_feedback_string
      Curriculum::Rateable::EXISTING_FEEDBACK
  end

  def key_stage_list_color(level)
    ['1', '2'].include?(level) ? 'curriculum__list--item-orange' : 'curriculum__list--item-purple'
  end

  def user_has_rated?(id)
    raw_cookie = cookies.encrypted[:ratings]
    ratings = JSON.parse(raw_cookie) unless raw_cookie.nil?
    ratings&.include?(id)
  end
end
