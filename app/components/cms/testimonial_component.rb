# frozen_string_literal: true

class Cms::TestimonialComponent < ViewComponent::Base
  def initialize(name:, job_title:, avatar:, quote:, background_color: nil)
    @name = name
    @job_title = job_title
    @avatar = avatar
    @quote = quote
    @background_color = background_color
  end

  def job_title_classes
    if dark_background?
      "job-title--light"
    else
      "job-title"
    end
  end

  def dark_background?
    %w[purple].include?(@background_color)
  end
end
