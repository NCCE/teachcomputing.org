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

      def self.resource_key
        "primary-computing-glossary-tables"
      end
    end
  end
end
