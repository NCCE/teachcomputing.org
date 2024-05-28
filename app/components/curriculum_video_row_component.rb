# frozen_string_literal: true

class CurriculumVideoRowComponent < ViewComponent::Base
  erb_template <<~ERB
    <div class="curriculum-video-component govuk-!-margin-top-8">
      <h2 class="govuk-heading-m careers-video-card__title govuk-!-margin-bottom-2">Career video to support the unit</h2>
      <%= render YouTubeEmbedComponent.new(video_url: @video_url) %>
      <div class="curriculum-video-component--details">
        <div class="curriculum-video-component--details__name govuk-body-m govuk-!-margin-bottom-0">
          <%= image_pack_tag("media/images/icons/person-green.svg", class: "curriculum-video-component--details__image", role: "presentation") %>
          <%= @name %>
        </div>
        <div class="curriculum-video-component--details__job-title govuk-body-m govuk-!-margin-bottom-0">
          <%= image_pack_tag("media/images/icons/job-green.svg", class: "curriculum-video-component--details__image", role: "presentation") %>
          <%= @job_title %>
        </div>
      </div>
      <p class="govuk-body-s"><%= @description %></p>
      <%= link_to "See more careers videos", tech_careers_videos_path, class: "govuk-button ncce-button--white curriculum-video-component--details__button" %>
    </div>
  ERB

  def initialize(video_url:, name: nil, job_title: nil, description: nil)
    @video_url = video_url
    @name = name
    @job_title = job_title
    @description = description
  end

  def render?
    @video_url.present?
  end
end
