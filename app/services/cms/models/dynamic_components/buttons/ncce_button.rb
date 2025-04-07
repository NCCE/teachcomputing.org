module Cms
  module Models
    module DynamicComponents
      module Buttons
        class NcceButton
          attr_accessor :title, :link, :color, :logged_in_title, :logged_in_link

          def initialize(title:, link:, color:, logged_in_title:, logged_in_link:)
            @title = title
            @link = link
            @color = color
            @logged_in_title = logged_in_title
            @logged_in_link = logged_in_link
          end

          def render
            Cms::NcceButtonComponent.new(title:, link:, color:, logged_in_title:, logged_in_link:)
          end
        end
      end
    end
  end
end
