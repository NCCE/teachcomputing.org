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
        super(context: :redirects, fields: fields)
      end

      def self.one(from, from_context, fields = FIELDS)
        super(context: :redirect, fields: fields, params: { from: from, from_context: from_context })
      end
    end
  end
end
