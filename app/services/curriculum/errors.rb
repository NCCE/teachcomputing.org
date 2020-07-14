class Curriculum::Errors
  class SchemaLoadError < StandardError; end
  class ConnectionError < StandardError; end
  class UnparsedQuery < StandardError; end
  class UnsupportedType < StandardError; end
end
