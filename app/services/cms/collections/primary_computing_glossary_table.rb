module Cms
  module Collections
    class PrimaryComputingGlossaryTable < CollectionResource
      def self.attribute_mappings
        {
          Alogrithm: {
            component: nil
          },
          keyStage: {
            component: nil
          },
          definition: {
            component: nil
          }
        }
      end

      def self.resource_key(params: {})
        url = "primary-computing-glossary-tables"
        url += "/#{params[:id]}" if params[:id]
        url
      end
    end
  end
end
