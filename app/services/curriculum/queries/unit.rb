module Curriculum
  module Queries
    class Unit
      FIELDS = %w[id title slug description unitGuide summativeAssessments summativeAnswers learningGraphs rubrics lessons ].freeze

      ALL = <<~GRAPHQL.freeze
        query {
          units{
            #{FIELDS.join(' ')}
          }
        }
      GRAPHQL

      ONE = <<~GRAPHQL.freeze
        query($id: ID!) {
          unit(id: $id) {
            #{FIELDS.join(' ')}
          }
        }
      GRAPHQL

      def self.all
        Curriculum::Request.run(ALL)
      end

      def self.one(id)
        Curriculum::Request.run(ONE, { id: id })
      end
    end
  end
end
