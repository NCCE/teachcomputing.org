module Cms
  module EmailComponents
    class Cta < BaseComponent
      attr_accessor :text, :link

      def initialize(text:, link:)
        @text = text
        @link = link
      end

      def render(email_template, user)
        NcceButtonComponent.new(title: @text, link:)
      end

      def render_text(email_template, user)
        CtaText.new(@text, @link)
      end
    end

    class CtaText
      def initialize(text, link)
        @text = text
        @link = link
      end

      def render_in(view_context)
        view_context.render inline: "#{@text} (#{@link})\n"
      end

      def format = :text
    end
  end
end
