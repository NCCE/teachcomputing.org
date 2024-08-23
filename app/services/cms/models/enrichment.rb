module Cms
  module Models
    class Enrichment
      attr_accessor :title, :details, :link, :featured, :i_belong, :terms, :type, :age_groups, :partner_icon

      def initialize(title:, details:, link:, featured:, i_belong:, terms:, type:, age_groups:, partner_icon: nil)
        @title = title
        @details = details
        @featured = featured
        @i_belong = i_belong
        @terms = terms
        @type = type
        @age_groups = age_groups
        @partner_icon = partner_icon
      end

      def render
        CmsEnrichmentComponent.new(
          title:,
          details:,
          link:,
          i_belong:,
          terms:,
          type:,
          age_groups:,
          partner_icon:
        )
      end
    end
  end
end
