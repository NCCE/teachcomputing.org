require "rails_helper"

RSpec.describe PrimaryLandingPage do
  let!(:primary_cert) { instance_double(Programmes::PrimaryCertificate) }
  let(:user) { create(:user) }

  let(:landing_page) { described_class.new(current_user: user) }

  before do
    allow(Programme).to receive(:primary_certificate) { primary_cert }
  end

  it "exposes primary certificate" do
    expect(landing_page.primary_certificate).to eq(primary_cert)
  end

  describe "#meta" do
    it "returns correctly shaped data" do
      keys = %i[title description image image_alt]

      expect(landing_page.meta.keys).to eq(keys)
    end
  end

  describe "#heading" do
    it "returns text" do
      expect(landing_page.heading).to eq("The essential toolkit for primary computing teachers")
    end
  end

  describe "#hero_text" do
    it "returns text" do
      expect(landing_page.hero_text)
        .to eq("Training and enrichment to help you teach and lead the computing curriculum and improve learning across your school.")
    end
  end

  describe "#hero_image" do
    it "returns image path" do
      expect(landing_page.hero_image).to eq("media/images/landing-pages/pri-hero.png")
    end
  end

  describe "#hero_class" do
    it "returns lime-green-bg" do
      expect(landing_page.hero_class).to eq("lime-green-bg")
    end
  end

  describe "#event_tracking_category" do
    it "returns lime-green-bg" do
      expect(landing_page.event_tracking_category).to eq("Primary teachers")
    end
  end

  describe "#certificates_text" do
    it "returns text" do
      expect(landing_page.certificates_text).to match(/Designed for primary teachers/)
    end
  end

  describe "#secondary?" do
    it "returns false" do
      expect(landing_page.secondary?).to eq(false)
    end
  end

  describe "#primary?" do
    it "returns true" do
      expect(landing_page.primary?).to eq(true)
    end
  end

  describe "#primary_cert_link_text" do
    context "when user enrolled on primary certificate" do
      it "returns correct text" do
        allow(primary_cert).to receive(:user_completed?)
        allow(primary_cert).to receive(:user_enrolled?).and_return(true)
        expect(landing_page.primary_cert_link_text).to eq("View your progress")
      end
    end

    context "when user completes primary certificate" do
      it "returns correct text" do
        allow(primary_cert).to receive(:user_enrolled?)
        allow(primary_cert).to receive(:user_completed?).and_return(true)
        expect(landing_page.primary_cert_link_text).to eq("View certificate")
      end
    end

    context "when user not enrolled on primary certificate" do
      it "returns correct text" do
        allow(primary_cert).to receive(:user_completed?)
        allow(primary_cert).to receive(:user_enrolled?).and_return(false)
        expect(landing_page.primary_cert_link_text).to eq("Find out more")
      end
    end
  end

  describe "#primary_tracking_event" do
    context "when user enrolled on primary" do
      it "returns correct text" do
        allow(primary_cert).to receive(:user_enrolled?).and_return(true)
        expect(landing_page.primary_tracking_event).to eq("Primary view progress")
      end
    end

    context "when user not enrolled on primary" do
      it "returns correct text" do
        allow(primary_cert).to receive(:user_enrolled?).and_return(false)
        expect(landing_page.primary_tracking_event).to eq("Primary find out more")
      end
    end
  end

  describe "#testimonials" do
    it "returns nil" do
      expect(landing_page.testimonials).to eq(nil)
    end
  end

  describe "#courses_intro" do
    it "returns text" do
      expect(landing_page.courses_intro).to match(/Develop your understanding/)
    end
  end

  describe "#courses" do
    it "returns 3 courses" do
      expect(landing_page.courses.length).to eq(3)
    end

    it "returns correctly shaped data" do
      keys = %i[image image_title title url description icon_class type duration time_commitment event_label]

      expect(landing_page.courses.map(&:keys)).to eq([keys, keys, keys.reject { |k| k == :duration }])
    end
  end

  describe "#resources_text" do
    it "returns text" do
      expect(landing_page.resources_text).to match(/Our free resources/)
    end
  end

  describe "#resources" do
    it "returns 2 resources" do
      expect(landing_page.resources.length).to eq(2)
    end

    it "returns correctly shaped data" do
      keys = %i[title url description event_label updated_at]

      expect(landing_page.resources.map(&:keys)).to eq(Array.new(2, keys))
    end
  end
end
