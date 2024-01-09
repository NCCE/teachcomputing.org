module CurriculumClient
  module Queries
    class Lesson < CurriculumClient::Queries::BaseQuery
      extend CurriculumClient::Queries::RateableQuery
      CONTEXT = :lesson

      FIELDS = <<~GRAPHQL.freeze
        id
        title
        order
        range
        slug
        description
        isaacUrl
        zippedContents {
          #{file_fields}
        }
        unit {
          slug
          title
          order
          yearGroup {
            yearNumber
            keyStage {
              shortTitle
              slug
              level
            }
          }
        }
        learningObjectives {
          id
          description
          successCriteria {
            id
            description
          }
        }
      GRAPHQL

      def self.all(fields = FIELDS)
        super(context: :lessons, fields:, cache_key: "lesson--all")
      end

      def self.one(slug, unit_slug, fields = FIELDS)
        super(context: :lesson, fields:, params: {slug:, unit_slug:}, cache_key: "lesson--#{unit_slug}-#{slug}")
      end
    end
  end
end
