module Programmes
  class CSAccelerator
    class PathwayRecommender
      PATHWAY_MAP = {
        A: "new-to-computing",
        B: "prepare-to-teach-gcse-computer-science",
        C: "new-to-algorithms-and-programming",
        D: "new-to-computer-systems",
        E: "advanced-gcse-computer-science"
      }.freeze

      def initialize(questionnaire_response:)
        @answers = questionnaire_response.answers.transform_values { |val| val.to_i }
        @score = questionnaire_response.score
      end

      def recommended_pathway
        Pathway.find_by(slug: PATHWAY_MAP[pathway_map_key_from_answers])
      end

      private

      def pathway_map_key_from_answers
        return :A if specific_questions_have_possible_answer?(questions: %w[1], possible_answers: [1])

        case @score
        when 2..10
          :B
        when 11..14
          key_from_middle_banding
        when 15..20
          key_from_upper_banding
        end
      end

      def key_from_middle_banding
        return :B unless single_a_or_b_response?

        key_from_single_low_confidence_answer
      end

      def key_from_upper_banding
        return :E unless any_a_or_b_responses?
        return :B if multiple_a_or_b_responses?

        key_from_single_low_confidence_answer
      end

      def single_a_or_b_response?
        @answers.values.count { |answer| [1, 2].include?(answer) } == 1
      end

      def any_a_or_b_responses?
        @answers.values.select { |answer| [1, 2].include?(answer) }.any?
      end

      def multiple_a_or_b_responses?
        @answers.values.count { |answer| [1, 2].include?(answer) } > 1
      end

      def specific_questions_have_possible_answer?(questions:, possible_answers:)
        @answers.slice(*questions).values.intersection(possible_answers).any?
      end

      def key_from_single_low_confidence_answer
        # If answered B to Q1
        return :B if specific_questions_have_possible_answer?(questions: %w[1], possible_answers: [2])

        # If answered A or B to Q2 or Q4
        return :C if specific_questions_have_possible_answer?(questions: %w[2 4], possible_answers: [1, 2])

        # They must have answered A or B to Q3 or Q5
        :D
      end
    end
  end
end
