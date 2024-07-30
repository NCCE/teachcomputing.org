module Cms
  module Errors
    class NoCmsProviderDefined < StandardError; end

    class NotACmsCollection < StandardError
      def initialize
        super("Enable is_collection if this resource is a collection")
      end
    end
  end
end
