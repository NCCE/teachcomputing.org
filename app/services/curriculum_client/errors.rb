module CurriculumClient
  class Errors
    class SchemaLoadError < StandardError; end
    class ConnectionError < StandardError; end
    class UnparsedQuery < StandardError; end
    class UnsupportedType < StandardError; end
    class RecordNotFound < StandardError; end
  end
end
