module Cms
  module Providers
    module Strapi
      module_function

      def configure
        yield(configuration)
      end

      def configuration
        @instance ||= Configuration.new
      end
    end
  end
end
