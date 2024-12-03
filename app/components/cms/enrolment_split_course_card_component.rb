# frozen_string_literal: true

class Cms::EnrolmentSplitCourseCardComponent < CmsWithAsidesComponent
  delegate :current_user, to: :helpers

  def initialize(card_content:, aside_content:, enrol_aside:, section_title:, background_color:, color_theme:, aside_title:, aside_icon:, programme:)
    super(aside_sections: enrol_aside)
    @card_content = card_content
    @aside_content = aside_content
    @section_title = section_title
    @background_color = background_color
    @color_theme = color_theme
    @aside_title = aside_title
    @aside_icon = aside_icon
    @programme = programme
  end

  def before_render
    @enrolled = @programme.user_enrolled?(current_user)
  end
end
