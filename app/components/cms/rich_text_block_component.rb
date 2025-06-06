# Due to how ERB interacts with newlines and spaces the markup for any
# SubClasses should not include any indentation and should make use of
# `-` at the end of ERB tags
class Cms::RichTextBlockComponent < ViewComponent::Base
  def build(blocks, **)
    klass =
      case blocks
      in { type: "paragraph" } then Paragraph
      in { type: "heading" } then Heading
      in { type: "text" } then Text
      in { type: "link" } then Link
      in { type: "list" } then List
      in { type: "list-item" } then ListItem
      in { type: "image" } then Image
      in { type: "quote"} then Quote
      end

    klass.new(blocks: blocks, **)
  end

  erb_template <<~ERB
    <% if @with_wrapper %>
      <div class="govuk-width-container cms-rich-text-block-component">
        <div class="govuk-main-wrapper">
          <div class="govuk-grid-row">
            <div class="govuk-grid-column-two-thirds">
              <% @blocks.each do |child| -%>
                <%= render build(child) -%>
              <% end -%>
            </div>
          </div>
        </div>
      </div>
    <% else %>
      <div class="cms-rich-text-block-component">
        <% @blocks.each do |child| -%>
          <%= render build(child, **@options) -%>
        <% end -%>
      </div>
    <% end %>
  ERB

  def initialize(blocks:, with_wrapper: false, **options)
    @blocks = blocks
    @with_wrapper = with_wrapper
    @options = options
  end

  class Paragraph < Cms::RichTextBlockComponent
    erb_template <<~ERB
      <p class="<%= paragraph_class %>">
      <% @blocks[:children].each do |child| -%>
      <%= render build(child) -%>
      <% end -%>
      </p>
    ERB

    def paragraph_class
      return @options[:paragraph_class] if @options[:paragraph_class]
      "govuk-body-m"
    end
  end

  class Heading < Cms::RichTextBlockComponent
    erb_template <<~ERB
      <h1 class="<%= heading_class %>">
      <% @blocks[:children].each do |child| -%>
      <%= render build(child) -%>
      <% end -%>
      </h1>
    ERB

    def heading_class
      if @blocks[:level] == 1
        "govuk-heading-l"
      elsif @blocks[:level] == 2 || @blocks[:level] == 3
        "govuk-heading-m"
      else
        "govuk-heading-s"
      end
    end
  end

  class Text < Cms::RichTextBlockComponent
    def call
      if @blocks[:text] == "---"
        content_tag(:hr)
      elsif @blocks[:code]
        content_tag(:span, @blocks[:text].html_safe, class: classes)
      else
        content_tag(:span, sanitize(@blocks[:text]), class: classes)
      end
    end

    def classes
      classes = []
      classes << "cms-rich-text-block-component__text--bold" if @blocks.key?(:bold)
      classes << "cms-rich-text-block-component__text--italic" if @blocks.key?(:italic)
      classes << "cms-rich-text-block-component__text--strikethrough" if @blocks.key?(:strikethrough)
      classes << "cms-rich-text-block-component__text--code" if @blocks.key?(:code)
      classes << "cms-rich-text-block-component__text--underline" if @blocks.key?(:underline)

      classes.join(" ")
    end
  end

  class Link < Cms::RichTextBlockComponent
    # Had to removed indentation in this erb as it was adding whitespace to page render
    erb_template <<~ERB
      <%= link_to @blocks[:url], class: "ncce-link" do -%>
      <% @blocks[:children].each do |child| -%>
      <%= render build(child) -%>
      <% end -%>
      <% end -%>
    ERB
  end

  class List < Cms::RichTextBlockComponent
    erb_template <<~ERB
      <%= content_tag(tag, class: classes) do -%>
      <% @blocks[:children].each do |child| -%>
      <%= render build(child) -%>
      <% end -%>
      <% end -%>
    ERB

    def tag
      (@blocks[:format] == "ordered") ? :ol : :ul
    end

    def classes
      classes = ["govuk-list"]
      classes << "govuk-list--bullet" if tag == :ul
      classes << "govuk-list--number" if tag == :ol
      classes << @options[:list_class] if @options[:list_class]
      classes.join(" ")
    end
  end

  class ListItem < Cms::RichTextBlockComponent
    erb_template <<~ERB
      <li>
      <% @blocks[:children].each do |child| -%>
      <%= render build(child) -%>
      <% end -%>
      </li>
    ERB
  end

  class Image < Cms::RichTextBlockComponent
    erb_template <<~ERB
      <%= render Cms::ImageComponent.new(
        @blocks[:image]
      ) -%>
    ERB
  end

  class Quote < Cms::RichTextBlockComponent
    erb_template <<~ERB
      <blockquote class="govuk-body-m">
      <% @blocks[:children].each do |child| -%>
      <%= render build(child) -%>
      <% end -%>
      </blockquote>
    ERB
  end
end
