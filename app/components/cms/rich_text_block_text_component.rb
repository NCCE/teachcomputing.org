# Due to how ERB interacts with newlines and spaces the markup for any
# SubClasses should not include any indentation and should make use of
# `-` at the end of ERB tags
module Cms
  class RichTextBlockTextComponent < ViewComponent::Base
    def build(blocks, **options)
      klass =
        case blocks
        in { type: "paragraph" } then Paragraph
        in { type: "heading" } then Heading
        in { type: "text" } then Text
        in { type: "link" } then Link
        in { type: "list" } then List
        in { type: "list-item" } then ListItem
        in { type: "quote"} then Quote
        end

      klass.new(blocks: blocks, **options)
    end

    erb_template <<~ERB
      <% @blocks.each do |child| -%>
      <%= render build(child) %> \n
      <% end -%>
    ERB

    def initialize(blocks:, **options)
      @blocks = blocks
      @options = options
    end

    class Paragraph < RichTextBlockTextComponent
      erb_template <<~ERB
        <% @blocks[:children].each do |child| -%>
        <%= render build(child) -%>
        <% end -%>
      ERB
    end

    class Heading < RichTextBlockTextComponent
      erb_template <<~ERB
        <% @blocks[:children].each do |child| -%>
        <%= render build(child) -%>
        <% end -%>
      ERB
    end

    class Text < RichTextBlockTextComponent
      erb_template <<~ERB
        <%= @blocks[:text] -%>
      ERB
    end

    class Link < RichTextBlockTextComponent
      # Had to removed indentation in this erb as it was adding whitespace to page render
      erb_template <<~ERB
        <% @blocks[:children].each do |child| -%>
        <%= render build(child) -%>
        <% end -%>
        <%= url -%>
      ERB

      def url
        " (#{@blocks[:url]})"
      end
    end

    class List < RichTextBlockTextComponent
      erb_template <<~ERB
        <% @blocks[:children].each_with_index do |child, index| -%>
        <%= render build(child, type:, index:) -%>
        <% end -%>
      ERB

      def type
        @blocks[:format]
      end
    end

    class ListItem < RichTextBlockTextComponent
      erb_template <<~ERB
        <% @blocks[:children].each do |child| -%>
        <%= icon -%> <%= render build(child) %>
        <% end -%>
      ERB

      def icon
        if @options[:type] == "ordered"
          "#{@options[:index] + 1}."
        else
          "*"
        end
      end
    end

    class Quote < RichTextBlockTextComponent
      erb_template <<~ERB
        <% @blocks[:children].each do |child| -%>
        <%= render build(child) -%>
        <% end -%>
      ERB
    end
  end
end
