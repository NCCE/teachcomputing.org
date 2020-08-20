module CurriculumHelper
  def get_feedback_string
    Curriculum::Rateable::EXISTING_FEEDBACK
  end

  def key_stage_list_color(level)
    %w[1 2].include?(level) ? 'curriculum__list--item-orange' : 'curriculum__list--item-purple'
  end

  def generate_download_url(contents_url)
    modified_url = contents_url.dup
    return modified_url << "?user_stem_achiever_contact_no=#{current_user.stem_achiever_contact_no}" if current_user

    contents_url
  end

  def year_group_title(year_number)
    return year_number if year_number.include?('GCSE')

    "Year #{year_number}"
  end

  def user_has_rated?(id)
    raw_cookie = cookies.encrypted[:ratings]
    ratings = JSON.parse(raw_cookie) unless raw_cookie.nil?
    ratings&.include?(id)
  end

  def sorted_years(years)
    years.sort_by(&:year_number)
  end
end
