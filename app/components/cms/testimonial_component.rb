# frozen_string_literal: true

class Cms::TestimonialComponent < ViewComponent::Base
  delegate :dark_background?, to: :helpers

  def initialize(name:, job_title:, avatar:, quote:, background_color: nil)
    @name = name
    @job_title = job_title
    @avatar = avatar
    @quote = quote
    @background_color = background_color
  end

  def job_title_classes
    return "job-title--light" if dark_background?(@background_color)

    "job-title"
  end
end
