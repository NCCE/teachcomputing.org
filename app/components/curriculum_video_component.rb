# frozen_string_literal: true

class CurriculumVideoComponent < ViewComponent::Base
  def initialize(video_url:, name: nil, job_title: nil, description: nil, layout: :col)
    @video_url = video_url
    @name = name
    @job_title = job_title
    @description = description
    @layout = layout
  end

  def layout_class
    if @layout == :col
      "col"
    else
      "row"
    end
  end

  def render?
    @video_url.present?
  end
end
