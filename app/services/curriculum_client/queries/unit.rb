module CurriculumClient
  module Queries
    class Unit < CurriculumClient::Queries::BaseQuery
      extend CurriculumClient::Queries::RateableQuery
      CONTEXT = :unit

      FIELDS = <<~GRAPHQL.freeze
        id
        title
        slug
        description
        unitGuide
        summativeAssessments
        summativeAnswers
        learningGraphs
        rubrics
        yearGroup {
          yearNumber
          slug
          keyStage {
            slug
            shortTitle
            level
          }
        }
        lessons {
          id
          slug
          description
          zippedContents
          title
          objectives
        }
      GRAPHQL

      def self.all(fields = FIELDS)
        super(:units, fields)
      end

      def self.one(slug, fields = FIELDS)
        super(:unit, fields, :slug, slug)
      end
    end
  end
end
