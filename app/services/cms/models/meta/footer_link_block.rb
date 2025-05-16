module Cms
  module Models
    module Meta
      class FooterLinkBlock
        attr_accessor :link_block

        def initialize(link_block:)
          @link_block = link_block
        end

        def process_blocks
          @link_block.map do |block|
            {
              links: block[:links].map do |link|
                link
              end
            }
          end
        end
      end
    end
  end
end
