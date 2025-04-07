module Cms
  module Models
    module EmailComponents
      class Text < BaseComponent
        attr_accessor :blocks

        def initialize(blocks:)
          @blocks = blocks
        end

        def render(email_template, user)
          Cms::RichTextBlockComponent.new(blocks: email_template.process_blocks(@blocks, user), with_wrapper: false)
        end

        def render_text(email_template, user)
          Cms::RichTextBlockTextComponent.new(blocks: email_template.process_blocks(@blocks, user))
        end
      end
    end
  end
end
