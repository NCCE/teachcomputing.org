module Cms
  module DynamicComponents
    class Testimonial
      attr_accessor :name, :job_title, :avatar, :quote

      def initialize(name:, job_title:, avatar:, quote:)
        @name = name
        @job_title = job_title
        @avatar = avatar
        @quote = quote
      end

      def render(background_color: nil)
        CmsTestimonialComponent.new(name:, job_title:, avatar:, quote:, background_color:)
      end
    end
  end
end
