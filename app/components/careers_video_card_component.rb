# frozen_string_literal: true

class CareersVideoCardComponent < ViewComponent::Base
  def initialize(video_url:, title:, name:, job_title:, description:)
    @video_url = video_url
    @title = title
    @name = name
    @job_title = job_title
    @description = description
  end
end
