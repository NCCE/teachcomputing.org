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
  let(:enrolled_aside_slug) { [{slug: "enrolment-testimonial-logged-in-aside"}] }
  let(:enrol_aside_slug) { [{slug: "enrol-testimonial-aside"}] }

  before do
    stub_strapi_aside_section(enrolled_aside_slug.first[:slug], aside_data: {title: "I am enrolled"})
    stub_strapi_aside_section(enrol_aside_slug.first[:slug], aside_data: {title: "Ready to enrol?"})
  end

  context "User not logged in" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(nil)
      render_inline(described_class.new(
        title: Faker::Lorem.sentence,
        testimonial: Cms::Mocks::DynamicComponents::ContentBlocks::Testimonial.as_model,
        enrolled_aside: enrolled_aside_slug,
        enrol_aside: enrol_aside_slug,
        programme_slug: programme.slug,
        background_color: "purple"
      ))
    end

    it "should show testimonial" do
      expect(page).to have_css(".cms-testimonial")
    end

    it "should render correct aside" do
      expect(page).to have_css(".aside-component__heading", text: "Ready to enrol?")
    end
  end

  context "user logged in but not enrolled" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(unenrolled_user)
      render_inline(described_class.new(
        title: Faker::Lorem.sentence,
        testimonial: Cms::Mocks::DynamicComponents::ContentBlocks::Testimonial.as_model,
        enrolled_aside: enrolled_aside_slug,
        enrol_aside: enrol_aside_slug,
        programme_slug: programme.slug,
        background_color: "purple"
      ))
    end

    it "should show testimonial" do
      expect(page).to have_css(".cms-testimonial")
    end

    it "should not render an aside" do
      expect(page).to have_css(".aside-component__heading", text: "Ready to enrol?")
    end
  end

  context "user logged in and enrolled" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(enrolled_user)
      render_inline(described_class.new(
        title: Faker::Lorem.sentence,
        testimonial: Cms::Mocks::DynamicComponents::ContentBlocks::Testimonial.as_model,
        enrolled_aside: enrolled_aside_slug,
        enrol_aside: enrol_aside_slug,
        programme_slug: programme.slug,
        background_color: "purple"
      ))
    end

    it "should show testimonial" do
      expect(page).to have_css(".cms-testimonial")
    end

    it "should render an aside" do
      expect(page).to have_css(".aside-component__heading", text: "I am enrolled")
    end
  end
end
