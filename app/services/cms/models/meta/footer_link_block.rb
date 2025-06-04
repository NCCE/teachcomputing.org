module Cms
  module Models
    module Meta
      class FooterLinkBlock
        attr_accessor :link_blocks

        def initialize(link_blocks:)
          @link_blocks = link_blocks
        end
      end
    end
  end
end
