module Cms
  module Models
    module Collections
      class EmailTemplate
        include ActionView::Helpers::DateHelper

        attr_accessor :slug, :email_content, :programme, :completed_programme_activity_groups, :activity_state, :enrolled

        def initialize(slug:, subject:, email_content:, programme_slug:, completed_programme_activity_group_slugs:, activity_state:, enrolled:)
          @slug = slug
          @subject = subject
          @email_content = email_content
          @programme_slug = programme_slug
          @programme = Programme.find_by(slug: @programme_slug)
          @completed_programme_activity_group_slugs = completed_programme_activity_group_slugs
          @completed_programme_activity_groups = if completed_programme_activity_group_slugs
            completed_programme_activity_group_slugs.map { ProgrammeActivityGrouping.find_by(cms_slug: _1) }
          else
            []
          end
          @activity_state = activity_state
          @enrolled = enrolled
        end

        def subject(user)
          merge_content(@subject, user)
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
              ["{last_cpd_completed_ago}", time_ago_in_words(achievement.updated_at)],
              ["{last_cpd_completed_year}", "in #{achievement.updated_at.year}"],
              ["{last_cpd_title}", achievement.activity.title]
            ]
          end
          new_text = text.dup # to unfreeze the string
          merges.each { new_text.gsub!(_1[0], _1[1]) }
          new_text
        end
      end
    end
  end
end
