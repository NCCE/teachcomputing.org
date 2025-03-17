module Cms
  module DynamicComponents
    class MultiStateLink
      attr_accessor :programme, :logged_out_link_title, :logged_out_link, :not_enrolled_link_title, :not_enrolled_link,
        :enrolled_link_title, :enrolled_link

      def initialize(programme:, logged_out_link_title:, logged_out_link:, not_enrolled_link_title:, not_enrolled_link:, enrolled_link_title:, enrolled_link:)
        @programme = programme
        @logged_out_link_title = logged_out_link_title
        @logged_out_link = logged_out_link
        @not_enrolled_link_title = not_enrolled_link
        @enrolled_link_title = enrolled_link_title
        @enrolled_link = enrolled_link
      end

      def render
        Cms::MultiStateLinkComponent.new(
          programme:,
          logged_out_link_title:,
          logged_out_link:,
          not_enrolled_link_title:,
          not_enrolled_link:,
          enrolled_link_title:,
          enrolled_link:
        )
      end
    end
  end
end
