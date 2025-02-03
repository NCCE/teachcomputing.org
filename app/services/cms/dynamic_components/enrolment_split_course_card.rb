module Cms
  module DynamicComponents
    class EnrolmentSplitCourseCard
      attr_accessor :card_content, :aside_content, :enrol_aside, :section_title, :background_color, :color_theme, :aside_title, :aside_icon, :programme

      def initialize(card_content:, aside_content:, enrol_aside:, section_title:, background_color:, color_theme:, aside_title:, aside_icon:, programme_slug:)
        @card_content = card_content
        @aside_content = aside_content
        @enrol_aside = enrol_aside
        @section_title = section_title
        @background_color = background_color
        @color_theme = color_theme
        @aside_title = aside_title
        @aside_icon = aside_icon
        @programme = Programme.find_by(slug: programme_slug)
      end

      def render
        EnrolmentSplitCourseCardComponent.new(card_content:, aside_content:, enrol_aside:, section_title:, background_color:,
          color_theme:, aside_title:, aside_icon:, programme:)
      end
    end
  end
end
