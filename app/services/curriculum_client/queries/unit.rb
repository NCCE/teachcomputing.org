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
        redirects {
          from
          to
        }
        isaacUrl
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
        }
      GRAPHQL

      def self.all(fields = FIELDS)
        super(context: :units, fields: fields, cache_key: 'unit--all')
      end

      def self.one(slug, fields = FIELDS)
        super(context: :unit, fields: fields, params: { slug: slug }, cache_key: "unit--#{slug}")
      end
    end
  end
end
