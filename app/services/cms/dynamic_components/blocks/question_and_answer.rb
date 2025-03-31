module Cms
  module DynamicComponents
    module Blocks
      class QuestionAndAnswer
        attr_accessor :question, :answer, :aside_sections, :answer_icon_block, :aside_alignment, :show_background_triangle

        def initialize(question:, answer:, aside_sections:, answer_icon_block:, aside_alignment:, show_background_triangle:)
          @question = question
          @answer = answer
          @aside_sections = aside_sections
          @answer_icon_block = answer_icon_block
          @aside_alignment = aside_alignment
          @show_background_triangle = show_background_triangle
        end

        def render
          Cms::QuestionAndAnswerComponent.new(question:, answer:, aside_sections:, answer_icon_block:, aside_alignment:, show_background_triangle:)
        end
      end
    end
  end
end
