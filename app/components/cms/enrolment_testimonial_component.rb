# frozen_string_literal: true

class Cms::EnrolmentTestimonialComponent < CmsWithAsidesComponent
  delegate :current_user, to: :helpers

  def initialize(title:, testimonial:, enrolled_aside:, enrol_aside:, programme_slug:, background_color:)
    super(aside_sections: enrolled_aside + enrol_aside)

    @enrolled_aside_slug = if enrolled_aside.any?
      enrolled_aside.first[:slug]
    end
    @enrol_aside_slug = enrol_aside.first[:slug]
    @title = title
    @testimonial = testimonial
    @programme = Programme.find_by(slug: programme_slug)
    @background_color = background_color
  end

  def before_render
    @enrolled = @programme.user_enrolled?(current_user)
    if @enrolled
      hide_aside(@enrol_aside_slug)
    elsif @enrolled_aside_slug
      hide_aside(@enrolled_aside_slug)
    end
  end
end
