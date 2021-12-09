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
        super(context: :yearGroups, fields: fields, cache_key: 'year_group--all')
      end

      def self.one(slug, fields = FIELDS)
        super(context: :yearGroup, fields: fields, params: { slug: slug }, cache_key: "year_group--#{slug}")
      end
    end
  end
end
