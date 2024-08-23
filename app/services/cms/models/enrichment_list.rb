module Cms
  module Models
    class EnrichmentList
      attr_accessor :enrichments, :featured_title, :all_title

      def initialize(enrichments:, featured_title:, all_title:)
        @enrichments = enrichments
        @featured_title = featured_title
        @all_title = all_title
      end

      def render
        CmsEnrichmentListComponent.new(enrichments:, featured_title:, all_title:)
      end
    end
  end
end
