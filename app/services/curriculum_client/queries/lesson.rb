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
        objectives
        zippedContents
        unit {
          slug
          title
          yearGroup {
            yearNumber
            keyStage {
              shortTitle
              slug
            }
          }
        }
      GRAPHQL

      def self.all(fields = FIELDS)
        super(:lessons, fields, 'lesson--all')
      end

      def self.one(slug, fields = FIELDS)
        super(:lesson, fields, :slug, slug, "lesson--#{slug}")
      end
    end
  end
end
