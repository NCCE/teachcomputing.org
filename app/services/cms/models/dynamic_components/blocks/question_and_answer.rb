module Cms
  module Models
    module DynamicComponents
      module Blocks
        class QuestionAndAnswer < HasAsides
          attr_accessor :question, :answer, :answer_icon_block, :aside_alignment, :show_background_triangle

          def initialize(question:, answer:, aside_sections:, answer_icon_block:, aside_alignment:, show_background_triangle:)
            super(aside_sections)
            @question = question
            @answer = answer
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
end
