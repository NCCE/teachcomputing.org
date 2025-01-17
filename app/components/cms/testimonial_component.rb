# frozen_string_literal: true

class Cms::TestimonialComponent < ViewComponent::Base
  def initialize(name:, job_title:, avatar:, quote:)
    @name = name
    @job_title = job_title
    @avatar = avatar
    @quote = quote
  end
end
