module Cms
  module Models
    class HasAsides
      include ContainsCached

      attr_accessor :aside_sections

      def initialize(aside_sections)
        @aside_sections = aside_sections
      end

      def aside_slugs
        @aside_sections.map { _1[:slug] }
      end

      def clear_cache
        aside_slugs.each { Cms::Collections::AsideSection.clear_cache(_1) }
      end
    end
  end
end
