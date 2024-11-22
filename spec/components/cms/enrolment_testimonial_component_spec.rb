# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::EnrolmentTestimonialComponent, type: :component do
  let!(:programme) { create(:primary_certificate) }
  let(:unenrolled_user) { create(:user) }
  let(:enrolled_user) {
    user = create(:user)
    create(:user_programme_enrolment, user:, programme:)
    user
  }
  let(:aside_slug) { [{slug: "enrolment-testimonial-logged-in-aside"}] }

  before do
    stub_strapi_aside_section(aside_slug.first[:slug])
  end

  context "User not logged in" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(nil)
      render_inline(described_class.new(
        title: Faker::Lorem.sentence,
        testimonial: Cms::Mocks::Testimonial.as_model,
        enrolled_aside: aside_slug,
        programme_slug: programme.slug,
        background_color: "purple"
      ))
    end

    it "should show testimonial" do
      expect(page).to have_css(".cms-testimonial")
    end

    it "should not render an aside" do
      expect(page).not_to have_css(".aside-component")
    end
  end

  context "user logged in but not enrolled" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(unenrolled_user)
      render_inline(described_class.new(
        title: Faker::Lorem.sentence,
        testimonial: Cms::Mocks::Testimonial.as_model,
        enrolled_aside: aside_slug,
        programme_slug: programme.slug,
        background_color: "purple"
      ))
    end

    it "should show testimonial" do
      expect(page).to have_css(".cms-testimonial")
    end

    it "should not render an aside" do
      expect(page).not_to have_css(".aside-component")
    end
  end

  context "user logged in and enrolled" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(enrolled_user)
      render_inline(described_class.new(
        title: Faker::Lorem.sentence,
        testimonial: Cms::Mocks::Testimonial.as_model,
        enrolled_aside: aside_slug,
        programme_slug: programme.slug,
        background_color: "purple"
      ))
    end

    it "should show testimonial" do
      expect(page).to have_css(".cms-testimonial")
    end

    it "should render an aside" do
      expect(page).to have_css(".aside-component")
    end
  end
end
