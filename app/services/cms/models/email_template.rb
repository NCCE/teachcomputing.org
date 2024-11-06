module Cms
  module Models
    class EmailTemplate
      attr_accessor :slug, :subject, :ctas

      def initialize(slug:, subject:, email_content:, ctas:)
        @slug = slug
        @subject = subject
        @email_content = email_content
        @ctas = ctas
      end

      def email_content(user)
        content = @email_content.deep_dup
        content.each { search_for_text(_1, user) }
        content
      end

      def search_for_text(node, user)
        if node[:type] == "text"
          node[:text] = merge_content(node[:text], user)
        end
        node[:children]&.each do |child|
          search_for_text(child, user)
        end
        node
      end

      def merge_content(text, user)
        merges = [
          ["{first_name}", user.first_name]
        ]
        merges.each { text.gsub!(_1[0], _1[1]) }
        text
      end

      def render
      end
    end
  end
end
