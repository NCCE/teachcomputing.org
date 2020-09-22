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
        super(context: :units, fields: fields, cache_key: 'unit--all')
      end

      def self.one(slug, fields = FIELDS)
        super(context: :unit, fields: fields, key: :slug, value: slug, cache_key: "unit--#{slug}")
      end
    end
  end
end
