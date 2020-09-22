module CurriculumClient
  module Queries
    class YearGroup < CurriculumClient::Queries::BaseQuery
      FIELDS = <<~GRAPHQL.freeze
        id
        slug
        keyStage
        yearNumber
        units
      GRAPHQL

      def self.all(fields = FIELDS)
        super(:yearGroups, fields, 'year_group--all')
      end

      def self.one(slug, fields = FIELDS)
        super(:yearGroup, fields, :slug, slug, "year_group--#{slug}")
      end
    end
  end
end
