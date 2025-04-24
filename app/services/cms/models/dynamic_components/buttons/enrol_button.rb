module Cms
  module Models
    module DynamicComponents
      module Buttons
        class EnrolButton
          attr_accessor :logged_out_button_text, :logged_in_button_text, :programme

          def initialize(logged_out_button_text:, logged_in_button_text:, programme_slug:)
            @logged_out_button_text = logged_out_button_text
            @logged_in_button_text = logged_in_button_text
            @programme = Programme.find_by(slug: programme_slug)
          end

          def render
            EnrolmentConfirmationComponent.new(programme:, logged_out_button_text:, logged_in_button_text:)
          end
        end
      end
    end
  end
end
