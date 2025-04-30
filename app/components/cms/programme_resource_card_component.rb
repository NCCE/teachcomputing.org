# frozen_string_literal: true

class Cms::ProgrammeResourceCardComponent < ViewComponent::Base
  delegate :current_user, :cms_color_theme_class, to: :helpers

  def initialize(title:, logged_out_text_content:, not_enrolled_text_content:, enrolled_text_content:, programme:, color_theme: nil, button: nil)
    @title = title
    @logged_out_text_content = logged_out_text_content
    @not_enrolled_text_content = not_enrolled_text_content
    @enrolled_text_content = enrolled_text_content
    @programme = programme
    @color_theme = color_theme
    @button = button
  end

  def wrapper_classes
    classes = ["cms-programme-resource-card-component", "white-bg"]
    classes << cms_color_theme_class(@color_theme, "top") if @color_theme
    classes
  end

  def text_content
    return @logged_out_text_content unless current_user

    if @programme.user_enrolled?(current_user)
      @enrolled_text_content
    else
      @not_enrolled_text_content
    end
  end

  def render?
    @programme.present?
  end
end
