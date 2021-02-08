module Programmes
  class CSAccelerator
    class PathwayRecommender
      PATHWAY_MAP = {
        A: 'new_to_computing',
        B: 'preparing_to_teach',
        C: 'algorithms_and_programming',
        D: 'systems',
        E: 'advanced'
      }.freeze

      def initialize(questionnaire_response:)
        @answers = Hash[questionnaire_response.answers.map { |k, str| [k, str.to_i] }]
        @score = questionnaire_response.score
      end

      def recommended_pathway
        pathway_from_score
      end

      private

        def pathway_from_score
          key = case @score
                when 1
                  :A
                when 2..10
                  :B
                when 11..14
                  key_from_middle_banding
                end
          Pathway.find_by(slug: PATHWAY_MAP[key])
        end

        def key_from_middle_banding
          return :B unless single_a_or_b_response?
          # If answered B to Q1
          return :B if specific_questions_have_possible_answer?(questions: %w[1], possible_answers: [2])

          # If answered A or B to Q2 or Q4
          return :C if specific_questions_have_possible_answer?(questions: %w[2 4], possible_answers: [1, 2])

          # They must have answered A or B to Q3 or Q5
          :D
        end

        def single_a_or_b_response?
          @answers.values.select { |answer| [1, 2].include?(answer) }.length == 1
        end

        def specific_questions_have_possible_answer?(questions:, possible_answers:)
          @answers.slice(*questions).values.intersection(possible_answers).any?
        end
    end
  end
end
