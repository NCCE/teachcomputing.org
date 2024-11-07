module Cms
  module EmailComponents
    class Text
      attr_accessor :blocks

      def initialize(blocks:)
        @blocks = blocks
      end

      def render(email_template, user)
        CmsRichTextBlockComponent.new(blocks: email_template.process_blocks(@blocks, user), with_wrapper: false)
      end

      def render_text(email_template, user)
        CmsRichTextBlockTextComponent.new(blocks: email_template.process_blocks(@blocks, user))
      end
    end
  end
end
