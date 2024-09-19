module Cms
  module Models
    class EnrichmentType
      attr_accessor :name, :icon

      def initialize(name:, icon:)
        @name = name
        @icon = icon
      end
    end
  end
end
