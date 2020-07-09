module Curriculum
  module Queries
    class Assessment
      FIELDS = %w[id unit title description rubric summativeAssessment sheets].freeze

      ALL = <<~GRAPHQL.freeze
        query {
          assessments {
            #{FIELDS.join(' ')}
          }
        }
      GRAPHQL

      ONE = <<~GRAPHQL.freeze
        query($id: ID!) {
          assessment(id: $id) {
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
