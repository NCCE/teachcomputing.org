module Cms
  module Models
    module Meta
      class FooterLinkBlock
        attr_accessor :link_block

        def initialize(link_block:)
          @link_block = link_block
        end

        def process_blocks
          @link_block.each do |block|
            block
          end
        end

        def render
          Cms::FooterComponent.new(link_block:)
        end
      end
    end
  end
end
