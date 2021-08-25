module CurriculumClient
  module Queries
    class KeyStage < CurriculumClient::Queries::BaseQuery
      FIELDS = <<~GRAPHQL.freeze
        id
        title
        slug
        shortTitle
        level
        ages
        description
        yearGroups {
          slug
          yearNumber
          units {
            id
            title
            slug
          }
        }
        curriculumMaps {
          name
          file
        }
        lessonCount
        unitCount
        teacherGuide
        years
      GRAPHQL

      def self.all(fields = FIELDS)
        super(context: :keyStages, fields: fields, cache_key: 'key_stage--all')
      end

      def self.one(slug, fields = FIELDS)
        super(context: :keyStage, fields: fields, key: :slug, value: slug, cache_key: "key_stage--#{slug}")
      end
    end
  end
end
