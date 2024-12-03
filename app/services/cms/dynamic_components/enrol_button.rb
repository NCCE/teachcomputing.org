module Cms
  module DynamicComponents
    class EnrolButton
      attr_accessor :button_text, :programme

      def initialize(button_text:, programme_slug:)
        @button_text = button_text
        @programme = Programme.find_by(slug: programme_slug)
      end

      def render
        EnrolmentConfirmationComponent.new(programme:, button_text:)
      end
    end
  end
end
