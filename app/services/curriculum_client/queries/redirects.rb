module CurriculumClient
  module Queries
    class Redirects < CurriculumClient::Queries::BaseQuery
      CONTEXT = :redirect

      FIELDS = <<~GRAPHQL.freeze
        from,
        to
      GRAPHQL

      def self.all(fields = FIELDS)
        super(context: :redirects, fields: fields, cache_key: 'redirect--all')
      end
    end
  end
end
