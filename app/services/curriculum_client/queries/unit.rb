module CurriculumClient
  module Queries
    class Unit < CurriculumClient::Queries::BaseQuery
      extend CurriculumClient::Queries::RateableQuery
      CONTEXT = :unit

      FIELDS = <<~GRAPHQL.freeze
        id
        title
        slug
        order
        description
        isaacUrl
        redirects {
          from
          to
        }
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
          order
          range
          redirects {
            from
            to
          }
        }
      GRAPHQL

      def self.all(fields = FIELDS)
        super(context: :units, fields: fields, cache_key: 'unit--all')
      end

      def self.one(slug, key_stage_slug, fields = FIELDS)
        super(context: :unit, fields: fields, params: { slug: slug, key_stage_slug: key_stage_slug }, cache_key: "unit--#{key_stage_slug}-#{slug}")
      end
    end
  end
end
