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
        unitGuide {
          #{file_fields}
        }
        summativeAssessments {
          #{file_fields}
        }
        summativeAnswers {
          #{file_fields}
        }
        learningGraphs {
          #{file_fields}
        }
        rubrics {
          #{file_fields}
        }
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
          title
          description
          learningObjectives {
            id
            description
            successCriteria {
              id
              description
            }
          }
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
