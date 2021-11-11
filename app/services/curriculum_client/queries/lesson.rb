module CurriculumClient
  module Queries
    class Lesson < CurriculumClient::Queries::BaseQuery
      extend CurriculumClient::Queries::RateableQuery
      CONTEXT = :lesson

      FIELDS = <<~GRAPHQL.freeze
        id
        unit
        title
        slug
        description
        zippedContents {
          #{file_fields}
        }
        unit {
          slug
          title
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
        super(context: :lessons, fields: fields, cache_key: 'lesson--all')
      end

      def self.one(slug, fields = FIELDS)
        super(context: :lesson, fields: fields, key: :slug, value: slug, cache_key: "lesson--#{slug}")
      end
    end
  end
end
