module CurriculumClient
  module Queries
    class FileUpload < CurriculumClient::Queries::BaseQuery
      FIELDS = <<~GRAPHQL.freeze
        id
        slug
        name
        file
        type
        size
        created
      GRAPHQL

      def self.one(slug, fields = FIELDS)
        super(context: :fileUpload, fields:, params: {slug:}, cache_key: "file_upload--#{slug}")
      end
    end
  end
end
