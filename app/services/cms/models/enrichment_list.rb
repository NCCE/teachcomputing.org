module Cms
  module Models
    class EnrichmentList
      attr_accessor :enrichments, :featured_title, :all_title, :type_filter_placeholder, :age_group_filter_placeholder, :term_filter_placeholder

      def initialize(enrichments:, featured_title:, all_title:, type_filter_placeholder:, age_group_filter_placeholder:, term_filter_placeholder:)
        @enrichments = enrichments
        @featured_title = featured_title
        @all_title = all_title
        @type_filter_placeholder = type_filter_placeholder
        @age_group_filter_placeholder = age_group_filter_placeholder
        @term_filter_placeholder = term_filter_placeholder
      end

      def render
        Cms::EnrichmentListComponent.new(
          enrichments:,
          featured_title:,
          all_title:,
          type_filter_placeholder:,
          age_group_filter_placeholder:,
          term_filter_placeholder:
        )
      end
    end
  end
end
