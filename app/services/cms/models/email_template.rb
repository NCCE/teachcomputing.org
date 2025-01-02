module Cms
  module Models
    class EmailTemplate
      attr_accessor :slug, :subject, :email_content, :programme

      def initialize(slug:, subject:, email_content:, programme_slug:)
        @slug = slug
        @subject = subject
        @email_content = email_content
        @programme_slug = programme_slug
        @programme = Programme.find_by(slug: @programme_slug)
      end

      def process_blocks(blocks, user)
        content = blocks.deep_dup
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
        achievements = user.sorted_completed_cpd_achievements_by(programme: @programme)
        if achievements.any?
          achievement = achievements.last
          merges += [
            ["{last_cpd_completed_ago}", time_diff_words(achievement.updated_at)],
            ["{last_cpd_completed_year}", "in #{achievement.updated_at.year}"],
            ["{last_cpd_title}", achievement.activity.title]
          ]
        end
        merges.each { text.gsub!(_1[0], _1[1]) }
        text
      end

      def time_diff_words(date)
        diff = DateTime.now.to_i - date.to_i
        months = diff / (60 * 60 * 24 * 30)
        if months >= 12
          "#{months / 12} #{"year".pluralize(months / 12)}"
        else
          "#{months} #{"month".pluralize(months)}"
        end
      end
    end
  end
end
