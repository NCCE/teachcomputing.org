# frozen_string_literal: true

class Cms::EnrolmentTestimonialComponent < CmsWithAsidesComponent
  delegate :current_user, to: :helpers

  def initialize(title:, testimonial:, enrolled_aside:, programme_slug:, background_color:)
    super(aside_sections: enrolled_aside)
    @title = title
    @testimonial = testimonial
    @programme = Programme.find_by(slug: programme_slug)
    @background_color = background_color
  end

  def before_render
    @enrolled = @programme.user_enrolled?(current_user)
  end
end
