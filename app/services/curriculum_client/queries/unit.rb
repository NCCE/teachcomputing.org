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
        displayIBelongFlag
        digitalSummativeAssessmentUrl
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
          zippedContents {
            #{file_fields}
          }
        }
      GRAPHQL

      def self.all(fields = FIELDS)
        super(context: :units, fields:, cache_key: "unit--all")
      end

      def self.one(slug, key_stage_slug, fields = FIELDS)
        super(context: :unit, fields:, params: {slug:, key_stage_slug:}, cache_key: "unit--#{key_stage_slug}-#{slug}")
      end
    end
  end
end
