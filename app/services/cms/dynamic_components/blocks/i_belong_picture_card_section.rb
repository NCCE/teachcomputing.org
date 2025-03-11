module Cms
  module DynamicComponents
    module Blocks
      class IBelongPictureCardSection
        attr_accessor :section_title, :i_belong_cards

        def initialize(section_title:, i_belong_cards:)
          @section_title = section_title
          @i_belong_cards = i_belong_cards
        end

        def render
          Cms::IBelongPictureCardSectionComponent.new(section_title:, i_belong_cards:)
        end
      end
    end
  end
end
