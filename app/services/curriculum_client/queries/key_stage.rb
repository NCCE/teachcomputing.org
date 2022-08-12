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
            order
          }
        }
        curriculumMaps {
          #{file_fields}
        }
        lessonCount
        unitCount
        teacherGuide {
          #{file_fields}
        }
        years
      GRAPHQL

      def self.all(fields = FIELDS)
        super(context: :keyStages, fields: fields, cache_key: 'key_stage--all')
      end

      def self.one(slug, fields = FIELDS)
        super(context: :keyStage, fields: fields, params: { slug: slug }, cache_key: "key_stage--#{slug}")
      end
    end
  end
end
