module CurriculumClient
  module Queries
    class Redirect < CurriculumClient::Queries::BaseQuery
      CONTEXT = :redirect

      FIELDS = <<~GRAPHQL.freeze
        from
        to
        toContext
      GRAPHQL

      def self.all(fields = FIELDS)
        super(context: :redirects, fields: fields, cache_key: 'redirect--all')
      end

      def self.one(from, from_context, fields = FIELDS)
        super(context: :redirect, fields: fields, params: { from: from, from_context: from_context }, cache_key: "redirect--#{from}")
      end
    end
  end
end
