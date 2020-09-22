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
        teacherGuide
        years
      GRAPHQL

      def self.all(fields = FIELDS)
        super(:keyStages, fields, 'key_stage--all')
      end

      def self.one(slug, fields = FIELDS)
        super(:keyStage, fields, :slug, slug, "key_stage--#{slug}")
      end
    end
  end
end
