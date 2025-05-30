module Cms
  module Models
    module Meta
      class FooterLinkBlock
        attr_accessor :link_blocks

        def initialize(link_blocks:)
          @link_blocks = link_blocks
        end

        def process_blocks
          @link_blocks.map do |block|
            block
          end
        end
      end
    end
  end
end
