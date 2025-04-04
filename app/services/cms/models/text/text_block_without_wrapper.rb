module Cms
  module Models
    module Text
      class TextBlockWithoutWrapper
        attr_accessor :blocks

        def initialize(blocks:, **options)
          @blocks = blocks
          @options = options
        end

        def render
          Cms::RichTextBlockComponent.new(blocks:, with_wrapper: false, **@options)
        end
      end
    end
  end
end
