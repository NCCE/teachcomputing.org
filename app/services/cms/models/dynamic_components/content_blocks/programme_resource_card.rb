module Cms
  module Models
    module DynamicComponents
      module ContentBlocks
        class ProgrammeResourceCard
          attr_accessor :title, :logged_out_text_content, :enrolled_text_content, :not_enrolled_text_content, :logged_out_button_text, :not_enrolled_button_text, :programme, :color_theme, :button

          def initialize(title:, logged_out_text_content:, not_enrolled_text_content:, enrolled_text_content:, programme:, color_theme: nil, button: nil)
            @title = title
            @logged_out_text_content = logged_out_text_content
            @not_enrolled_text_content = not_enrolled_text_content
            @enrolled_text_content = enrolled_text_content
            @programme = programme
            @color_theme = color_theme
            @button = button
          end

          def render
            Cms::ProgrammeResourceCardComponent.new(
              title:,
              logged_out_text_content:,
              not_enrolled_text_content:,
              enrolled_text_content:,
              programme:,
              color_theme:,
              button:
            )
          end
        end
      end
    end
  end
end
