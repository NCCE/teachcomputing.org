# frozen_string_literal: true

class CmsRichTextBlockComponent < ViewComponent::Base
  def build(obj)
    klass =
      case obj
      in { type: "paragraph" } then Paragraph
      in { type: "heading" } then Heading
      in { type: "text" } then Text
      in { type: "link" } then Link
      in { type: "list" } then List
      in { type: "list-item" } then ListItem
      in { type: "image" } then Image
      in { type: "quote"} then Quote
      end

    klass.new(blocks: obj)
  end

  erb_template <<~ERB
    <div class="govuk-width-container cms-rich-text-block-component">
      <div class="govuk-main-wrapper">
        <div class="govuk-grid-row">
          <div class="govuk-grid-column-two-thirds">
            <% @obj.each do |child| %>
              <%= render build(child) -%>
            <% end %>
          </div>
        </div>
      </div>
    </div>
  ERB

  def initialize(blocks:)
    @obj = blocks
  end

  class Paragraph < CmsRichTextBlockComponent
    erb_template <<~ERB
      <p class="govuk-body-m">
        <% @obj[:children].each do |child| %>
          <%= render build(child) -%>
        <% end %>
      </p>
    ERB
  end

  class Heading < CmsRichTextBlockComponent
    erb_template <<~ERB
      <h1 class="<%= classes %>">
        <% @obj[:children].each do |child| %>
          <%= render build(child) %>
        <% end %>
      </h1>
    ERB

    def classes
      if @obj[:level] == 1
        "govuk-heading-l"
      elsif @obj[:level] == 2
        "govuk-heading-m"
      else
        "govuk-heading-s"
      end
    end
  end

  class Text < CmsRichTextBlockComponent
    def call
      if @obj[:text] == "---"
        content_tag(:hr)
      elsif @obj[:code]
        content_tag(:div, raw(@obj[:text]), class: classes)
      else
        content_tag(:span, @obj[:text], class: classes)
      end
    end

    def classes
      classes = []
      classes << "cms-rich-text-block-component__text--bold" if @obj.key?(:bold)
      classes << "cms-rich-text-block-component__text--italic" if @obj.key?(:italic)
      classes << "cms-rich-text-block-component__text--strikethrough" if @obj.key?(:strikethrough)
      classes << "cms-rich-text-block-component__text--code" if @obj.key?(:code)
      classes << "cms-rich-text-block-component__text--underline" if @obj.key?(:underline)

      classes.join(" ")
    end
  end

  class Link < CmsRichTextBlockComponent
    erb_template <<~ERB
      <%= link_to @obj[:url], class: "ncce-link" do -%>
        <% @obj[:children].each do |child| %>
          <%= render build(child) -%>
        <% end -%>
      <% end -%>
    ERB
  end

  class List < CmsRichTextBlockComponent
    erb_template <<~ERB
      <%= content_tag(tag, class: classes) do %>
        <% @obj[:children].each do |child| %>
          <%= render build(child) %>
        <% end %>
      <% end %>
    ERB

    def tag
      (@obj[:format] == "ordered") ? :ol : :ul
    end

    def classes
      classes = ["govuk-list"]
      classes << "govuk-list--bullet" if tag == :ul
      classes.join(" ")
    end
  end

  class ListItem < CmsRichTextBlockComponent
    erb_template <<~ERB
      <li>
        <% @obj[:children].each do |child| %>
          <%= render build(child) %>
        <% end %>
      </li>
    ERB
  end

  class Image < CmsRichTextBlockComponent
    erb_template <<~ERB
      <%= render CmsImageComponent.new(@obj[:image], size: :medium) %>
    ERB
  end

  class Quote < CmsRichTextBlockComponent
    erb_template <<~ERB
      <blockquote class="govuk-body-m">
        <% @obj[:children].each do |child| %>
          <%= render build(child) %>
        <% end %>
      </blockquote>
    ERB
  end
end
