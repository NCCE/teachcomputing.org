# frozen_string_literal: true

class Cms::TwoColumnVideoSectionComponent < ViewComponent::Base
  def initialize(left_column_content:, video:, right_column_content:, background_color:)
    @left_column_content = left_column_content
    @video = video
    @right_column_content = right_column_content
    @background_color = background_color
  end
end
